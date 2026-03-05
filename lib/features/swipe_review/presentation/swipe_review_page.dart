import 'dart:io';

import 'package:bestshot/features/photo_picker/domain/selected_photo.dart';
import 'package:bestshot/features/photo_picker/presentation/photo_picker_provider.dart';
import 'package:bestshot/features/swipe_review/presentation/swipe_review_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bestshot/l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SwipeReviewPage extends ConsumerStatefulWidget {
  const SwipeReviewPage({super.key, this.selectedPhotos = const <SelectedPhoto>[]});

  final List<SelectedPhoto> selectedPhotos;

  @override
  ConsumerState<SwipeReviewPage> createState() => _SwipeReviewPageState();
}

class _SwipeReviewPageState extends ConsumerState<SwipeReviewPage> {
  bool _navigated = false;
  bool _isResettingFlow = false;
  bool _isDragging = false;
  bool _isAnimatingDecision = false;
  double _dragDx = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || widget.selectedPhotos.isEmpty) {
        return;
      }
      ref.read(swipeReviewControllerProvider.notifier).start(widget.selectedPhotos);
    });
  }

  @override
  void didUpdateWidget(covariant SwipeReviewPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldIds = oldWidget.selectedPhotos.map((p) => p.id).join(',');
    final newIds = widget.selectedPhotos.map((p) => p.id).join(',');
    if (oldIds != newIds) {
      _navigated = false;
      _dragDx = 0;
      _isDragging = false;
      _isAnimatingDecision = false;
      ref.read(swipeReviewControllerProvider.notifier).start(widget.selectedPhotos);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final reviewState = ref.watch(swipeReviewControllerProvider);
    final controller = ref.read(swipeReviewControllerProvider.notifier);

    ref.listen(swipeReviewControllerProvider, (previous, next) {
      if (_navigated || !next.isComplete) {
        return;
      }
      _navigated = true;
      final keptPhotos = controller.keptPhotos();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        context.go('/kept-grid', extra: keptPhotos);
      });
    });

    if (widget.selectedPhotos.isEmpty) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          middle: Text(l10n.swipeReviewNavTitle),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.swipeReviewNoSelectedTitle,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(l10n.swipeReviewNoSelectedMessage),
                  const SizedBox(height: 16),
                  CupertinoButton.filled(
                    onPressed: () => context.go('/photo-picker'),
                    child: Text(l10n.swipeReviewBackToPicker),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (!reviewState.initialized) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          middle: Text(l10n.swipeReviewNavTitle),
        ),
        child: const SafeArea(
          child: Center(child: CupertinoActivityIndicator()),
        ),
      );
    }

    final currentPhoto = reviewState.currentAsset;
    final nextPhoto =
        reviewState.currentIndex + 1 < reviewState.assets.length
            ? reviewState.assets[reviewState.currentIndex + 1]
            : null;

    final currentPhotoIndex = reviewState.currentIndex + 1;
    final totalCount = reviewState.totalCount;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: Text(l10n.swipeReviewNavTitle),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _isResettingFlow || _isAnimatingDecision
              ? null
              : _resetFlowToPhotoPicker,
          child: Text(l10n.commonStartOver),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              Text(
                l10n.swipeReviewKeptProgress(reviewState.keptCount, 4),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                currentPhoto != null
                    ? l10n.swipeReviewPhotoIndex(currentPhotoIndex, totalCount)
                    : l10n.swipeReviewComplete,
                style: const TextStyle(
                  color: CupertinoColors.secondaryLabel,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: currentPhoto == null
                    ? const Center(child: CupertinoActivityIndicator())
                    : _SwipeCard(
                        dragDx: _dragDx,
                        isDragging: _isDragging,
                        currentPhoto: currentPhoto,
                        nextPhoto: nextPhoto,
                        keepBadgeText: l10n.swipeDecisionKeepBadge,
                        skipBadgeText: l10n.swipeDecisionSkipBadge,
                        onHorizontalDragStart: _isAnimatingDecision
                            ? null
                            : (_) {
                                setState(() {
                                  _isDragging = true;
                                });
                              },
                        onHorizontalDragUpdate: _isAnimatingDecision
                            ? null
                            : (details) {
                                setState(() {
                                  _dragDx = (_dragDx + details.delta.dx).clamp(-360, 360);
                                });
                              },
                        onHorizontalDragEnd: _isAnimatingDecision
                            ? null
                            : (details) async {
                                setState(() {
                                  _isDragging = false;
                                });
                                await _handleDragEnd(
                                  velocity: details.primaryVelocity ?? 0,
                                  controller: controller,
                                );
                              },
                      )
                          .animate(key: ValueKey(reviewState.currentIndex))
                          .fadeIn(duration: 200.ms)
                          .slideY(begin: 0.04, duration: 200.ms, curve: Curves.easeOut),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.swipeReviewHint,
                style: const TextStyle(color: CupertinoColors.secondaryLabel),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: CupertinoButton(
                      onPressed: reviewState.canUndo && !_isAnimatingDecision
                          ? () {
                              controller.undoLastDecision();
                              setState(() {
                                _dragDx = 0;
                              });
                            }
                          : null,
                      child: Text(l10n.swipeReviewUndo),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CupertinoButton(
                      onPressed: currentPhoto != null && !_isAnimatingDecision
                          ? () => _commitDecision(keep: false, controller: controller)
                          : null,
                      child: Text(l10n.swipeReviewSkip),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CupertinoButton.filled(
                      onPressed: currentPhoto != null && !_isAnimatingDecision
                          ? () => _commitDecision(keep: true, controller: controller)
                          : null,
                      child: Text(l10n.swipeReviewKeep),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleDragEnd({
    required double velocity,
    required SwipeReviewController controller,
  }) async {
    const positionThreshold = 110.0;
    const velocityThreshold = 650.0;

    if (_dragDx >= positionThreshold || velocity >= velocityThreshold) {
      await _commitDecision(keep: true, controller: controller);
      return;
    }
    if (_dragDx <= -positionThreshold || velocity <= -velocityThreshold) {
      await _commitDecision(keep: false, controller: controller);
      return;
    }

    setState(() {
      _dragDx = 0;
    });
  }

  Future<void> _commitDecision({
    required bool keep,
    required SwipeReviewController controller,
  }) async {
    if (_isAnimatingDecision || !mounted) {
      return;
    }

    final width = MediaQuery.sizeOf(context).width;
    setState(() {
      _isAnimatingDecision = true;
      _isDragging = false;
      _dragDx = keep ? width * 1.15 : -width * 1.15;
    });

    await Future<void>.delayed(const Duration(milliseconds: 180));
    if (!mounted) {
      return;
    }

    if (keep) {
      controller.keepCurrent();
    } else {
      controller.skipCurrent();
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _dragDx = 0;
      _isAnimatingDecision = false;
    });
  }

  Future<void> _resetFlowToPhotoPicker() async {
    final shouldReset = await _showResetConfirmDialog();
    if (!mounted || !shouldReset) {
      return;
    }
    setState(() {
      _isResettingFlow = true;
    });
    ref.read(swipeReviewControllerProvider.notifier).reset();
    ref.read(photoPickerControllerProvider.notifier).clearSelection();
    if (!mounted) {
      return;
    }
    context.go('/photo-picker');
  }

  Future<bool> _showResetConfirmDialog() async {
    final l10n = AppLocalizations.of(context);
    final result = await showCupertinoDialog<bool>(
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
    return result ?? false;
  }
}

class _SwipeCard extends StatelessWidget {
  const _SwipeCard({
    required this.dragDx,
    required this.isDragging,
    required this.currentPhoto,
    required this.nextPhoto,
    required this.keepBadgeText,
    required this.skipBadgeText,
    required this.onHorizontalDragStart,
    required this.onHorizontalDragUpdate,
    required this.onHorizontalDragEnd,
  });

  final double dragDx;
  final bool isDragging;
  final SelectedPhoto currentPhoto;
  final SelectedPhoto? nextPhoto;
  final String keepBadgeText;
  final String skipBadgeText;
  final GestureDragStartCallback? onHorizontalDragStart;
  final GestureDragUpdateCallback? onHorizontalDragUpdate;
  final GestureDragEndCallback? onHorizontalDragEnd;

  @override
  Widget build(BuildContext context) {
    final keepOpacity = (dragDx / 130).clamp(0, 1).toDouble();
    final skipOpacity = (-dragDx / 130).clamp(0, 1).toDouble();
    final maxPeekOffset = (dragDx / 16).clamp(-10, 10).toDouble();

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth.clamp(260.0, 430.0).toDouble();
        final cardHeight = constraints.maxHeight.clamp(340.0, 620.0).toDouble();

        return Stack(
          alignment: Alignment.center,
          children: [
            if (nextPhoto != null)
              Transform.translate(
                offset: Offset(20 + maxPeekOffset * 0.3, 14),
                child: Transform.scale(
                  scale: 0.94,
                  child: SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: _ImageCard(
                      photo: nextPhoto!,
                      dimmed: true,
                    ),
                  ),
                ),
              ),
            AnimatedContainer(
              duration: isDragging ? Duration.zero : const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              transform: Matrix4.identity()
                ..translateByDouble(dragDx, 0, 0, 1)
                ..rotateZ(dragDx / 1700),
              child: SizedBox(
                width: cardWidth,
                height: cardHeight,
                child: GestureDetector(
                  onHorizontalDragStart: onHorizontalDragStart,
                  onHorizontalDragUpdate: onHorizontalDragUpdate,
                  onHorizontalDragEnd: onHorizontalDragEnd,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _ImageCard(photo: currentPhoto),
                      Positioned(
                        top: 14,
                        left: 14,
                        child: Opacity(
                          opacity: keepOpacity,
                          child: Transform.scale(
                            scale: 0.6 + 0.4 * keepOpacity,
                            child: _DecisionChip(
                              color: CupertinoColors.activeGreen,
                              text: keepBadgeText,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 14,
                        right: 14,
                        child: Opacity(
                          opacity: skipOpacity,
                          child: Transform.scale(
                            scale: 0.6 + 0.4 * skipOpacity,
                            child: _DecisionChip(
                              color: CupertinoColors.destructiveRed,
                              text: skipBadgeText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ImageCard extends StatelessWidget {
  const _ImageCard({required this.photo, this.dimmed = false});

  final SelectedPhoto photo;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey5.resolveFrom(context),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 18,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(
              File(photo.path),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              cacheWidth: 1200,
              filterQuality: FilterQuality.medium,
            ),
            if (dimmed)
              DecoratedBox(
                decoration: BoxDecoration(
                  color: CupertinoColors.black.withValues(alpha: 0.14),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DecisionChip extends StatelessWidget {
  const _DecisionChip({required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color, width: 1.4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
