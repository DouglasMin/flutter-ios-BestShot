import 'dart:io';

import 'package:bestshot/features/photo_picker/domain/selected_photo.dart';
import 'package:bestshot/features/photo_picker/presentation/photo_picker_provider.dart';
import 'package:bestshot/features/swipe_review/presentation/swipe_review_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bestshot/l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';

class KeptGridPage extends ConsumerWidget {
  const KeptGridPage({super.key, this.keptPhotos = const <SelectedPhoto>[]});

  final List<SelectedPhoto> keptPhotos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (keptPhotos.isEmpty) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          middle: Text(l10n.keptGridNavTitle),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.keptGridEmptyTitle,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.keptGridEmptyMessage,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  CupertinoButton.filled(
                    onPressed: () => context.go('/photo-picker'),
                    child: Text(l10n.keptGridBackToPicker),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final canProceed = keptPhotos.length == 4;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: Text(l10n.keptGridNavTitle),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _startOver(context, ref),
          child: Text(l10n.commonStartOver),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              Text(
                l10n.keptGridSummary(keptPhotos.length),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                canProceed ? l10n.keptGridReady : l10n.keptGridNeedExactly4,
                style: const TextStyle(color: CupertinoColors.secondaryLabel),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  itemCount: keptPhotos.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final photo = keptPhotos[index];
                    return _KeptPhotoTile(
                      photo: photo,
                      index: index,
                    )
                        .animate()
                        .fadeIn(delay: (index * 80).ms, duration: 350.ms)
                        .slideY(
                          begin: 0.15,
                          delay: (index * 80).ms,
                          duration: 350.ms,
                          curve: Curves.easeOutCubic,
                        );
                  },
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: canProceed
                      ? () => context.push('/layout-selection', extra: keptPhotos)
                      : null,
                  child: Text(l10n.keptGridProceedToLayout),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  onPressed: () => _startOver(context, ref),
                  child: Text(l10n.keptGridRedoReview),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startOver(BuildContext context, WidgetRef ref) async {
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
    if (!context.mounted || shouldReset != true) {
      return;
    }
    ref.read(swipeReviewControllerProvider.notifier).reset();
    ref.read(photoPickerControllerProvider.notifier).clearSelection();
    if (!context.mounted) {
      return;
    }
    context.go('/photo-picker');
  }
}

class _KeptPhotoTile extends StatelessWidget {
  const _KeptPhotoTile({
    required this.photo,
    required this.index,
  });

  final SelectedPhoto photo;
  final int index;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            File(photo.path),
            fit: BoxFit.cover,
            cacheWidth: 700,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: CupertinoColors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(99),
              ),
              child: Text(
                l10n.keptGridKeepTag(index + 1),
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
