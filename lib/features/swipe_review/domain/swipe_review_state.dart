import 'package:bestshot/features/photo_picker/domain/selected_photo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'swipe_review_state.freezed.dart';

@freezed
abstract class SwipeDecision with _$SwipeDecision {
  const factory SwipeDecision({
    required String assetId,
    required bool kept,
  }) = _SwipeDecision;
}

@freezed
abstract class SwipeReviewState with _$SwipeReviewState {
  const SwipeReviewState._();

  const factory SwipeReviewState({
    @Default(false) bool initialized,
    @Default(<SelectedPhoto>[]) List<SelectedPhoto> assets,
    @Default(0) int currentIndex,
    @Default(<String>[]) List<String> keptIds,
    @Default(<SwipeDecision>[]) List<SwipeDecision> history,
  }) = _SwipeReviewState;

  SelectedPhoto? get currentAsset =>
      currentIndex < assets.length ? assets[currentIndex] : null;

  int get keptCount => keptIds.length;

  int get totalCount => assets.length;

  bool get hasMoreToReview => currentAsset != null;

  bool get canUndo => history.isNotEmpty;

  bool get isComplete =>
      initialized && totalCount > 0 && (keptCount >= 4 || !hasMoreToReview);
}
