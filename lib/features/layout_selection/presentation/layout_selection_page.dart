import 'package:bestshot/features/layout_selection/domain/collage_layout.dart';
import 'package:bestshot/features/layout_selection/presentation/layout_selection_provider.dart';
import 'package:bestshot/features/photo_picker/domain/selected_photo.dart';
import 'package:bestshot/features/photo_picker/presentation/photo_picker_provider.dart';
import 'package:bestshot/features/swipe_review/presentation/swipe_review_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bestshot/l10n/app_localizations.dart';

class LayoutSelectionPage extends ConsumerWidget {
  const LayoutSelectionPage({
    super.key,
    this.keptPhotos = const <SelectedPhoto>[],
  });

  final List<SelectedPhoto> keptPhotos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final selectedLayoutAsync = ref.watch(layoutSelectionControllerProvider);
    final controller = ref.read(layoutSelectionControllerProvider.notifier);

    if (keptPhotos.length != 4) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          transitionBetweenRoutes: false,
          middle: Text(l10n.layoutSelectionNavTitle),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => _startOver(context, ref),
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
                    l10n.layoutSelectionNeedExactly4Title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.layoutSelectionNeedExactly4Message,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  CupertinoButton.filled(
                    onPressed: () => context.go('/kept-grid', extra: keptPhotos),
                    child: Text(l10n.layoutSelectionBackToKeptGrid),
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
        middle: Text(l10n.layoutSelectionNavTitle),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _startOver(context, ref),
          child: Text(l10n.commonStartOver),
        ),
      ),
      child: SafeArea(
        child: selectedLayoutAsync.when(
          loading: () => const Center(child: CupertinoActivityIndicator()),
          error: (error, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.layoutSelectionLoadError),
                  const SizedBox(height: 12),
                  CupertinoButton.filled(
                    onPressed: () =>
                        ref.invalidate(layoutSelectionControllerProvider),
                    child: Text(l10n.commonRetry),
                  ),
                ],
              ),
            ),
          ),
          data: (selectedLayout) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              children: [
                Text(
                  l10n.layoutSelectionTitle,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.layoutSelectionLastChoiceHint,
                  style: const TextStyle(color: CupertinoColors.secondaryLabel),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: [
                      _LayoutOptionCard(
                        layout: CollageLayout.vertical1x4,
                        isSelected:
                            selectedLayout == CollageLayout.vertical1x4,
                        onTap: () =>
                            controller.select(CollageLayout.vertical1x4),
                      ),
                      const SizedBox(height: 12),
                      _LayoutOptionCard(
                        layout: CollageLayout.grid2x2,
                        isSelected: selectedLayout == CollageLayout.grid2x2,
                        onTap: () => controller.select(CollageLayout.grid2x2),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                    child: CupertinoButton.filled(
                      onPressed: () async {
                        await controller.persistSelection();
                        if (!context.mounted) {
                          return;
                      }
                      context.push(
                        '/export',
                        extra: {
                          'assets': keptPhotos,
                          'layout': selectedLayout.storageKey,
                          },
                        );
                      },
                    child: Text(l10n.layoutSelectionContinue),
                  ),
                ),
              ],
            ),
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

class _LayoutOptionCard extends StatelessWidget {
  const _LayoutOptionCard({
    required this.layout,
    required this.isSelected,
    required this.onTap,
  });

  final CollageLayout layout;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final borderColor =
        isSelected ? CupertinoColors.activeBlue : CupertinoColors.systemGrey4;

    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(16),
          color: CupertinoColors.systemBackground.resolveFrom(context),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Expanded(child: _LayoutPreview(layout: layout)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _layoutTitle(l10n, layout),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _layoutSubtitle(l10n, layout),
                      style: const TextStyle(
                        color: CupertinoColors.secondaryLabel,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LayoutPreview extends StatelessWidget {
  const _LayoutPreview({required this.layout});

  final CollageLayout layout;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: layout == CollageLayout.vertical1x4
              ? Column(
                  children: List.generate(
                    4,
                    (index) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: index == 3 ? 0 : 6),
                        child: const DecoratedBox(
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey3,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _PreviewBlock()),
                          SizedBox(width: 6),
                          Expanded(child: _PreviewBlock()),
                        ],
                      ),
                    ),
                    SizedBox(height: 6),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _PreviewBlock()),
                          SizedBox(width: 6),
                          Expanded(child: _PreviewBlock()),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _PreviewBlock extends StatelessWidget {
  const _PreviewBlock();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey3,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );
  }
}

String _layoutTitle(AppLocalizations l10n, CollageLayout layout) {
  return switch (layout) {
    CollageLayout.vertical1x4 => l10n.layoutVerticalTitle,
    CollageLayout.grid2x2 => l10n.layoutGridTitle,
  };
}

String _layoutSubtitle(AppLocalizations l10n, CollageLayout layout) {
  return switch (layout) {
    CollageLayout.vertical1x4 => l10n.layoutVerticalSubtitle,
    CollageLayout.grid2x2 => l10n.layoutGridSubtitle,
  };
}
