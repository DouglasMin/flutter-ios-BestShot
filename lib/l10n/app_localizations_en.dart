// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'BestShot';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonStartOver => 'Start Over';

  @override
  String get commonOpenSettings => 'Open Settings';

  @override
  String get commonLoading => 'Loading...';

  @override
  String get homeHeadline => 'Pick your best\n4 shots today.';

  @override
  String get homeSubtitle =>
      'Swipe fast, build a clean collage, and save instantly.';

  @override
  String get homeFeatureSwipeTitle => 'Fast swipe review';

  @override
  String get homeFeatureSwipeSubtitle => 'Right to keep, left to skip';

  @override
  String get homeFeatureLayoutTitle => 'Auto layouts';

  @override
  String get homeFeatureLayoutSubtitle => 'Choose 1x4 or 2x2 in seconds';

  @override
  String get homeStartPicking => 'Start picking photos';

  @override
  String get homeReplayOnboarding => 'View onboarding again';

  @override
  String get onboardingGatePreparing => 'Preparing BestShot...';

  @override
  String get onboardingGateLoadError => 'Could not load onboarding state.';

  @override
  String get onboardingIntroTitle => 'Your Best 4, Instantly.';

  @override
  String get onboardingIntroSubtitle =>
      'Swipe through your picks, keep only the strongest shots, and export a clean collage in seconds.';

  @override
  String get onboardingIntroCaption => 'Built for fast daily curation.';

  @override
  String get onboardingIntroStart => 'See How It Works';

  @override
  String get onboardingNavTitle => 'Get Started';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingStep1Title => 'Pick your photos';

  @override
  String get onboardingStep1Description =>
      'Choose photos from your library to review.';

  @override
  String get onboardingStep2Title => 'Swipe to select';

  @override
  String get onboardingStep2Description =>
      'Keep favorites and narrow down to top 4.';

  @override
  String get onboardingStep3Title => 'Export collage';

  @override
  String get onboardingStep3Description =>
      'Choose a layout, add caption, save or share.';

  @override
  String get onboardingAllowContinue => 'Get Started';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingErrorTitle => 'Something went wrong';

  @override
  String get onboardingErrorMessage =>
      'We could not complete onboarding. Please try again.';

  @override
  String get settingsOpenErrorTitle => 'Could not open Settings';

  @override
  String get settingsOpenErrorMessage =>
      'Please open iOS Settings manually and allow Photos access.';

  @override
  String get photoPickerNavTitle => 'Photo Picker';

  @override
  String get photoPickerEmpty => 'No photos found in your library.';

  @override
  String photoPickerReviewSelected(int count) {
    return 'Review $count selected photo(s)';
  }

  @override
  String get photoPickerInstruction =>
      'Select photos from your library to start review.';

  @override
  String get photoPickerSelectPhotos => 'Select Photos';

  @override
  String get photoPickerChangeSelection => 'Change Selection';

  @override
  String get photoPickerCancelled => 'No photos selected.';

  @override
  String get photoPickerFailed =>
      'Could not open photo picker. Please try again.';

  @override
  String get swipeReviewNavTitle => 'Swipe Review';

  @override
  String get swipeReviewNoSelectedTitle => 'No photos were selected.';

  @override
  String get swipeReviewNoSelectedMessage =>
      'Go back to Photo Picker and select photos first.';

  @override
  String get swipeReviewBackToPicker => 'Back to Photo Picker';

  @override
  String swipeReviewKeptProgress(int keptCount, int maxCount) {
    return '$keptCount/$maxCount kept';
  }

  @override
  String swipeReviewPhotoIndex(int index, int total) {
    return 'Photo $index / $total';
  }

  @override
  String get swipeReviewComplete => 'Review complete';

  @override
  String swipeReviewCapturedAt(String value) {
    return 'Captured $value';
  }

  @override
  String get swipeReviewHint => 'Swipe right to Keep, left to Skip';

  @override
  String get swipeReviewUndo => 'Undo';

  @override
  String get swipeReviewSkip => 'Skip';

  @override
  String get swipeReviewKeep => 'Keep';

  @override
  String get swipeDecisionKeepBadge => 'KEEP';

  @override
  String get swipeDecisionSkipBadge => 'SKIP';

  @override
  String get keptGridNavTitle => 'Kept Grid';

  @override
  String get keptGridEmptyTitle => 'No kept photos yet.';

  @override
  String get keptGridEmptyMessage => 'Go back and keep up to 4 photos first.';

  @override
  String get keptGridBackToPicker => 'Back to Photo Picker';

  @override
  String keptGridSummary(int count) {
    return '$count kept photo(s)';
  }

  @override
  String get keptGridReady => 'Great. You are ready to choose a layout.';

  @override
  String get keptGridNeedExactly4 =>
      'You need exactly 4 kept photos to continue.';

  @override
  String get keptGridProceedToLayout => 'Proceed to Layout';

  @override
  String get keptGridRedoReview => 'Redo Review';

  @override
  String keptGridKeepTag(int index) {
    return 'Keep $index';
  }

  @override
  String get layoutSelectionNavTitle => 'Layout Selection';

  @override
  String get layoutSelectionNeedExactly4Title =>
      'Exactly 4 kept photos are required.';

  @override
  String get layoutSelectionNeedExactly4Message =>
      'Go back and finish selection first.';

  @override
  String get layoutSelectionBackToKeptGrid => 'Back to Kept Grid';

  @override
  String get layoutSelectionLoadError => 'Could not load layout preference.';

  @override
  String get layoutSelectionTitle => 'Choose your collage layout';

  @override
  String get layoutSelectionLastChoiceHint =>
      'Your last choice is preselected.';

  @override
  String get layoutSelectionContinue => 'Continue to Export';

  @override
  String get layoutVerticalTitle => '1x4 Vertical';

  @override
  String get layoutVerticalSubtitle => 'Tall stack, story-friendly.';

  @override
  String get layoutGridTitle => '2x2 Grid';

  @override
  String get layoutGridSubtitle => 'Balanced square, feed-friendly.';

  @override
  String get exportNavTitle => 'Export';

  @override
  String get exportNeedExactly4Title =>
      'Exactly 4 photos are required for export.';

  @override
  String get exportNeedExactly4Message =>
      'Return to layout selection after choosing 4 kept photos.';

  @override
  String get exportBackToLayoutSelection => 'Back to Layout Selection';

  @override
  String get exportLoadSettingsError => 'Could not load export settings.';

  @override
  String exportLayoutLabel(String layout) {
    return 'Layout: $layout';
  }

  @override
  String get exportCaptionPlaceholder => 'Optional caption (single line)';

  @override
  String get exportNoPreview => 'No render preview yet.\nTap Render Preview.';

  @override
  String exportRenderPreviewButton(String preset) {
    return 'Render Preview ($preset)';
  }

  @override
  String get exportSave => 'Save';

  @override
  String get exportShare => 'Share';

  @override
  String get exportStatusRendering => 'Rendering collage...';

  @override
  String get exportStatusPreviewDone => 'Preview rendered.';

  @override
  String get exportStatusSaving => 'Saving to Photos...';

  @override
  String get exportStatusSaved => 'Saved to Photos.';

  @override
  String get exportStatusPreparingShare => 'Preparing share sheet...';

  @override
  String get exportStatusShared => 'Share sheet opened.';

  @override
  String get exportShareText => 'Made with BestShot';

  @override
  String get exportRenderFailedTitle => 'Render failed';

  @override
  String exportRenderFailedMessage(String error) {
    return 'Could not render collage: $error';
  }

  @override
  String get exportSaveFailedTitle => 'Save failed';

  @override
  String exportSaveFailedMessage(String error) {
    return 'Could not save collage: $error';
  }

  @override
  String get exportShareFailedTitle => 'Share failed';

  @override
  String exportShareFailedMessage(String error) {
    return 'Could not share collage: $error';
  }

  @override
  String get exportPermissionTitle => 'Photos permission required';

  @override
  String get exportPermissionMessage =>
      'BestShot needs permission to save exported images to your Photos.';

  @override
  String get resetConfirmTitle => 'Start over?';

  @override
  String get resetConfirmMessage =>
      'Current progress will be discarded and you will return to Photo Picker.';

  @override
  String get collageNavTitle => 'Collage';

  @override
  String get collagePlaceholder => 'Collage screen placeholder';
}
