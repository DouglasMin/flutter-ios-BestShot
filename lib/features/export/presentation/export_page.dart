import 'dart:io';

import 'package:bestshot/core/collage/collage_renderer.dart';
import 'package:bestshot/core/collage/collage_types.dart';
import 'package:bestshot/core/widget/home_screen_widget_service.dart';
import 'package:bestshot/features/export/presentation/export_provider.dart';
import 'package:bestshot/features/layout_selection/domain/collage_layout.dart';
import 'package:bestshot/features/photo_picker/domain/selected_photo.dart';
import 'package:bestshot/features/photo_picker/presentation/photo_picker_provider.dart';
import 'package:bestshot/features/swipe_review/presentation/swipe_review_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:bestshot/l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class ExportPage extends ConsumerStatefulWidget {
  const ExportPage({
    super.key,
    this.selectedPhotos = const <SelectedPhoto>[],
    this.selectedLayoutKey,
  });

  final List<SelectedPhoto> selectedPhotos;
  final String? selectedLayoutKey;

  @override
  ConsumerState<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends ConsumerState<ExportPage> {
  final CollageRenderer _renderer = const CollageRenderer();
  final TextEditingController _captionController = TextEditingController();

  Uint8List? _previewBytes;
  bool _isProcessing = false;
  String? _statusMessage;
  String? _lastRenderSignature;

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final presetAsync = ref.watch(exportSettingsControllerProvider);
    final selectedLayout = CollageLayoutX.fromStorageKey(widget.selectedLayoutKey);

    if (widget.selectedPhotos.length != 4) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          middle: Text(l10n.exportNavTitle),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: _isProcessing ? null : _startOver,
            child: Text(l10n.commonStartOver),
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.exportNeedExactly4Title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.exportNeedExactly4Message,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  CupertinoButton.filled(
                    onPressed: () => context.go('/layout-selection'),
                    child: Text(l10n.exportBackToLayoutSelection),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: Text(l10n.exportNavTitle),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _isProcessing ? null : _startOver,
          child: Text(l10n.commonStartOver),
        ),
      ),
      child: SafeArea(
        child: presetAsync.when(
          loading: () => const Center(child: CupertinoActivityIndicator()),
          error: (error, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.exportLoadSettingsError),
                  const SizedBox(height: 12),
                  CupertinoButton.filled(
                    onPressed: () => ref.invalidate(exportSettingsControllerProvider),
                    child: Text(l10n.commonRetry),
                  ),
                ],
              ),
            ),
          ),
          data: (selectedPreset) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.exportLayoutLabel(_layoutTitle(l10n, selectedLayout)),
                    style: const TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.secondaryLabel,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CupertinoSlidingSegmentedControl<ExportPreset>(
                    groupValue: selectedPreset,
                    children: const {
                      ExportPreset.ratio4x5: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Text('4:5'),
                      ),
                      ExportPreset.square1x1: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Text('1:1'),
                      ),
                      ExportPreset.ratio9x16: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Text('9:16'),
                      ),
                    },
                    onValueChanged: (value) async {
                      if (value == null) {
                        return;
                      }
                      ref
                          .read(exportSettingsControllerProvider.notifier)
                          .selectPreset(value);
                      await ref
                          .read(exportSettingsControllerProvider.notifier)
                          .persistSelectedPreset();
                      if (!mounted) {
                        return;
                      }
                      setState(() {
                        _previewBytes = null;
                        _lastRenderSignature = null;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  CupertinoTextField(
                    controller: _captionController,
                    maxLines: 1,
                    maxLength: 80,
                    inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
                    placeholder: l10n.exportCaptionPlaceholder,
                    onChanged: (_) {
                      setState(() {
                        _previewBytes = null;
                        _lastRenderSignature = null;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: _previewBytes != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.memory(
                                _previewBytes!,
                                fit: BoxFit.contain,
                              ),
                            )
                          : _isProcessing
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Shimmer.fromColors(
                                    baseColor: CupertinoColors.systemGrey5,
                                    highlightColor: CupertinoColors.systemGrey6,
                                    child: const DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: CupertinoColors.systemGrey5,
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    l10n.exportNoPreview,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                    ),
                  ),
                  if (_statusMessage != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      _statusMessage!,
                      style: const TextStyle(
                        color: CupertinoColors.secondaryLabel,
                        fontSize: 13,
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      onPressed: _isProcessing
                          ? null
                          : () => _renderPreview(
                                selectedPreset: selectedPreset,
                                layout: selectedLayout,
                              ),
                      child: _isProcessing
                          ? const CupertinoActivityIndicator(
                              color: CupertinoColors.white,
                            )
                          : Text(
                              l10n.exportRenderPreviewButton(
                                selectedPreset.displayName,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: CupertinoButton.filled(
                          onPressed: _isProcessing
                              ? null
                              : () => _saveToPhotos(
                                    selectedPreset: selectedPreset,
                                    layout: selectedLayout,
                                  ),
                          child: Text(l10n.exportSave),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CupertinoButton(
                          onPressed: _isProcessing
                              ? null
                              : () => _shareImage(
                                    selectedPreset: selectedPreset,
                                    layout: selectedLayout,
                                  ),
                          child: Text(l10n.exportShare),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _renderPreview({
    required ExportPreset selectedPreset,
    required CollageLayout layout,
  }) async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _isProcessing = true;
      _statusMessage = l10n.exportStatusRendering;
    });
    try {
      final bytes = await _renderCollageIfNeeded(
        selectedPreset: selectedPreset,
        layout: layout,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _previewBytes = bytes;
        _statusMessage = l10n.exportStatusPreviewDone;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      await _showMessageDialog(
        title: l10n.exportRenderFailedTitle,
        message: l10n.exportRenderFailedMessage('$error'),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<void> _saveToPhotos({
    required ExportPreset selectedPreset,
    required CollageLayout layout,
  }) async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _isProcessing = true;
      _statusMessage = l10n.exportStatusSaving;
    });
    try {
      final permission = await PhotoManager.requestPermissionExtend(
        requestOption: const PermissionRequestOption(
          iosAccessLevel: IosAccessLevel.addOnly,
        ),
      );

      if (!permission.hasAccess) {
        if (mounted) {
          await _showPermissionDialog();
        }
        return;
      }

      final bytes = await _renderCollageIfNeeded(
        selectedPreset: selectedPreset,
        layout: layout,
      );
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      await PhotoManager.editor.saveImage(
        bytes,
        filename: 'bestshot_$timestamp.png',
        title: 'bestshot_$timestamp',
      );
      await HomeScreenWidgetService.syncLatestExport(
        imageBytes: bytes,
        caption: _captionController.text.trim(),
        layout: layout.storageKey,
        preset: selectedPreset.storageKey,
      );

      if (!mounted) {
        return;
      }
      setState(() {
        _statusMessage = l10n.exportStatusSaved;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      await _showMessageDialog(
        title: l10n.exportSaveFailedTitle,
        message: l10n.exportSaveFailedMessage('$error'),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<void> _shareImage({
    required ExportPreset selectedPreset,
    required CollageLayout layout,
  }) async {
    final l10n = AppLocalizations.of(context);
    final box = context.findRenderObject() as RenderBox?;
    final shareOrigin = box != null
        ? box.localToGlobal(Offset.zero) & box.size
        : Rect.zero;
    setState(() {
      _isProcessing = true;
      _statusMessage = l10n.exportStatusPreparingShare;
    });
    try {
      final bytes = await _renderCollageIfNeeded(
        selectedPreset: selectedPreset,
        layout: layout,
      );

      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${tempDir.path}/bestshot_$timestamp.png');
      await file.writeAsBytes(bytes, flush: true);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: l10n.exportShareText,
        sharePositionOrigin: shareOrigin,
      );
      await HomeScreenWidgetService.syncLatestExport(
        imageBytes: bytes,
        caption: _captionController.text.trim(),
        layout: layout.storageKey,
        preset: selectedPreset.storageKey,
      );

      if (!mounted) {
        return;
      }
      setState(() {
        _statusMessage = l10n.exportStatusShared;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      await _showMessageDialog(
        title: l10n.exportShareFailedTitle,
        message: l10n.exportShareFailedMessage('$error'),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<Uint8List> _renderCollageIfNeeded({
    required ExportPreset selectedPreset,
    required CollageLayout layout,
  }) async {
    final caption = _captionController.text.trim();
    final signature = _renderSignature(
      preset: selectedPreset,
      layout: layout,
      caption: caption,
      photoIds: widget.selectedPhotos.map((p) => p.id),
    );
    if (_previewBytes != null && signature == _lastRenderSignature) {
      return _previewBytes!;
    }

    await ref.read(exportSettingsControllerProvider.notifier).persistSelectedPreset();
    final bytes = await _renderer.renderFromPhotos(
      photos: widget.selectedPhotos,
      layout: _toCoreLayoutType(layout),
      preset: selectedPreset,
      caption: caption,
    );
    if (!mounted) {
      return bytes;
    }
    setState(() {
      _previewBytes = bytes;
      _lastRenderSignature = signature;
    });
    return bytes;
  }

  CollageLayoutType _toCoreLayoutType(CollageLayout layout) {
    return switch (layout) {
      CollageLayout.vertical1x4 => CollageLayoutType.vertical1x4,
      CollageLayout.grid2x2 => CollageLayoutType.grid2x2,
    };
  }

  String _renderSignature({
    required ExportPreset preset,
    required CollageLayout layout,
    required String caption,
    required Iterable<String> photoIds,
  }) {
    final ids = photoIds.join(',');
    return '${preset.storageKey}|${layout.storageKey}|$caption|$ids';
  }

  Future<void> _showPermissionDialog() async {
    final l10n = AppLocalizations.of(context);
    await showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(l10n.exportPermissionTitle),
        content: Text(l10n.exportPermissionMessage),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.commonCancel),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () async {
              Navigator.of(context).pop();
              await _openSettingsSafely();
            },
            child: Text(l10n.commonOpenSettings),
          ),
        ],
      ),
    );
  }

  Future<void> _openSettingsSafely() async {
    try {
      await PhotoManager.openSetting();
    } catch (_) {
      if (!mounted) {
        return;
      }
      await _showMessageDialog(
        title: AppLocalizations.of(context).settingsOpenErrorTitle,
        message: AppLocalizations.of(context).settingsOpenErrorMessage,
      );
    }
  }

  Future<void> _showMessageDialog({
    required String title,
    required String message,
  }) async {
    await showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context).commonOk),
          ),
        ],
      ),
    );
  }

  Future<void> _startOver() async {
    final l10n = AppLocalizations.of(context);
    final shouldReset = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(l10n.resetConfirmTitle),
        content: Text(l10n.resetConfirmMessage),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.commonStartOver),
          ),
        ],
      ),
    );
    if (!mounted || shouldReset != true) {
      return;
    }
    ref.read(swipeReviewControllerProvider.notifier).reset();
    ref.read(photoPickerControllerProvider.notifier).clearSelection();
    if (!mounted) {
      return;
    }
    context.go('/photo-picker');
  }

  String _layoutTitle(AppLocalizations l10n, CollageLayout layout) {
    return switch (layout) {
      CollageLayout.vertical1x4 => l10n.layoutVerticalTitle,
      CollageLayout.grid2x2 => l10n.layoutGridTitle,
    };
  }
}
