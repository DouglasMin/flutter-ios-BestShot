import 'dart:io';

import 'package:bestshot/features/photo_picker/presentation/photo_picker_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bestshot/l10n/app_localizations.dart';

class PhotoPickerPage extends ConsumerStatefulWidget {
  const PhotoPickerPage({super.key});

  @override
  ConsumerState<PhotoPickerPage> createState() => _PhotoPickerPageState();
}

class _PhotoPickerPageState extends ConsumerState<PhotoPickerPage> {
  String? _statusMessage;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final photos = ref.watch(photoPickerControllerProvider);
    final controller = ref.read(photoPickerControllerProvider.notifier);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: Text(l10n.photoPickerNavTitle),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              const Spacer(),
              if (photos.isEmpty) ...[
                const Icon(
                  CupertinoIcons.photo_on_rectangle,
                  size: 72,
                  color: CupertinoColors.systemGrey,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.photoPickerEmpty,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.photoPickerInstruction,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: CupertinoColors.secondaryLabel,
                  ),
                ),
              ] else ...[
                Text(
                  l10n.photoPickerReviewSelected(photos.length),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  flex: 0,
                  child: SizedBox(
                    height: 200,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: photos.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(photos[index].path),
                            fit: BoxFit.cover,
                            cacheWidth: 400,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
              if (_statusMessage != null) ...[
                const SizedBox(height: 8),
                Text(
                  _statusMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: CupertinoColors.secondaryLabel,
                    fontSize: 13,
                  ),
                ),
              ],
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: () async {
                    final result = await controller.pickPhotos();
                    if (!mounted) {
                      return;
                    }
                    setState(() {
                      _statusMessage = switch (result) {
                        PhotoPickResult.selected => null,
                        PhotoPickResult.cancelled => l10n.photoPickerCancelled,
                        PhotoPickResult.failed => l10n.photoPickerFailed,
                      };
                    });
                  },
                  child: Text(
                    photos.isEmpty
                        ? l10n.photoPickerSelectPhotos
                        : l10n.photoPickerChangeSelection,
                  ),
                ),
              ),
              if (photos.isNotEmpty) ...[
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    onPressed: () {
                      context.push('/swipe-review', extra: photos);
                    },
                    child: Text(
                      l10n.photoPickerReviewSelected(photos.length),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                CupertinoButton(
                  onPressed: controller.clearSelection,
                  child: Text(l10n.commonStartOver),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
