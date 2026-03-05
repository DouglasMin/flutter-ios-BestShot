import 'package:bestshot/features/photo_picker/domain/selected_photo.dart';
import 'package:bestshot/features/swipe_review/domain/swipe_review_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'swipe_review_provider.g.dart';

@riverpod
class SwipeReviewController extends _$SwipeReviewController {
  @override
  SwipeReviewState build() => const SwipeReviewState();

  void start(List<SelectedPhoto> photos) {
    final nextIds = photos.map((p) => p.id).toList(growable: false);
    final currentIds = state.assets.map((p) => p.id).toList(growable: false);
    final isSameInput =
        state.initialized &&
        nextIds.length == currentIds.length &&
        nextIds.join(',') == currentIds.join(',');
    if (isSameInput) {
      return;
    }

    state = SwipeReviewState(
      initialized: true,
      assets: photos,
    );
  }

  void keepCurrent() => _applyDecision(kept: true);

  void skipCurrent() => _applyDecision(kept: false);

  void undoLastDecision() {
    if (!state.canUndo) {
      return;
    }

    final previousDecision = state.history.last;
    final nextHistory = [...state.history]..removeLast();
    final nextKeptIds = [...state.keptIds];

    if (previousDecision.kept) {
      final removalIndex = nextKeptIds.lastIndexOf(previousDecision.assetId);
      if (removalIndex >= 0) {
        nextKeptIds.removeAt(removalIndex);
      }
    }

    state = state.copyWith(
      currentIndex: state.currentIndex > 0 ? state.currentIndex - 1 : 0,
      history: nextHistory,
      keptIds: nextKeptIds,
    );
  }

  List<SelectedPhoto> keptPhotos() {
    if (state.keptIds.isEmpty) {
      return const <SelectedPhoto>[];
    }

    final byId = {
      for (final photo in state.assets) photo.id: photo,
    };

    return state.keptIds
        .map((id) => byId[id])
        .whereType<SelectedPhoto>()
        .toList(growable: false);
  }

  void reset() {
    state = const SwipeReviewState();
  }

  void _applyDecision({required bool kept}) {
    final currentAsset = state.currentAsset;
    if (currentAsset == null) {
      return;
    }

    final nextHistory = [
      ...state.history,
      SwipeDecision(assetId: currentAsset.id, kept: kept),
    ];
    final nextKeptIds = [...state.keptIds];
    if (kept) {
      nextKeptIds.add(currentAsset.id);
    }

    state = state.copyWith(
      currentIndex: state.currentIndex + 1,
      history: nextHistory,
      keptIds: nextKeptIds,
    );
  }
}
