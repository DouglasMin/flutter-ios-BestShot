import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'BestShot'**
  String get appName;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonStartOver.
  ///
  /// In en, this message translates to:
  /// **'Start Over'**
  String get commonStartOver;

  /// No description provided for @commonOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get commonOpenSettings;

  /// No description provided for @commonLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get commonLoading;

  /// No description provided for @homeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Pick your best\n4 shots today.'**
  String get homeHeadline;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Swipe fast, build a clean collage, and save instantly.'**
  String get homeSubtitle;

  /// No description provided for @homeFeatureSwipeTitle.
  ///
  /// In en, this message translates to:
  /// **'Fast swipe review'**
  String get homeFeatureSwipeTitle;

  /// No description provided for @homeFeatureSwipeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Right to keep, left to skip'**
  String get homeFeatureSwipeSubtitle;

  /// No description provided for @homeFeatureLayoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Auto layouts'**
  String get homeFeatureLayoutTitle;

  /// No description provided for @homeFeatureLayoutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose 1x4 or 2x2 in seconds'**
  String get homeFeatureLayoutSubtitle;

  /// No description provided for @homeStartPicking.
  ///
  /// In en, this message translates to:
  /// **'Start picking photos'**
  String get homeStartPicking;

  /// No description provided for @homeReplayOnboarding.
  ///
  /// In en, this message translates to:
  /// **'View onboarding again'**
  String get homeReplayOnboarding;

  /// No description provided for @onboardingGatePreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing BestShot...'**
  String get onboardingGatePreparing;

  /// No description provided for @onboardingGateLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load onboarding state.'**
  String get onboardingGateLoadError;

  /// No description provided for @onboardingIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Best 4, Instantly.'**
  String get onboardingIntroTitle;

  /// No description provided for @onboardingIntroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Swipe through your picks, keep only the strongest shots, and export a clean collage in seconds.'**
  String get onboardingIntroSubtitle;

  /// No description provided for @onboardingIntroCaption.
  ///
  /// In en, this message translates to:
  /// **'Built for fast daily curation.'**
  String get onboardingIntroCaption;

  /// No description provided for @onboardingIntroStart.
  ///
  /// In en, this message translates to:
  /// **'See How It Works'**
  String get onboardingIntroStart;

  /// No description provided for @onboardingNavTitle.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingNavTitle;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Pick your photos'**
  String get onboardingStep1Title;

  /// No description provided for @onboardingStep1Description.
  ///
  /// In en, this message translates to:
  /// **'Choose photos from your library to review.'**
  String get onboardingStep1Description;

  /// No description provided for @onboardingStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Swipe to select'**
  String get onboardingStep2Title;

  /// No description provided for @onboardingStep2Description.
  ///
  /// In en, this message translates to:
  /// **'Keep favorites and narrow down to top 4.'**
  String get onboardingStep2Description;

  /// No description provided for @onboardingStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Export collage'**
  String get onboardingStep3Title;

  /// No description provided for @onboardingStep3Description.
  ///
  /// In en, this message translates to:
  /// **'Choose a layout, add caption, save or share.'**
  String get onboardingStep3Description;

  /// No description provided for @onboardingAllowContinue.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingAllowContinue;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get onboardingErrorTitle;

  /// No description provided for @onboardingErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'We could not complete onboarding. Please try again.'**
  String get onboardingErrorMessage;

  /// No description provided for @settingsOpenErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Could not open Settings'**
  String get settingsOpenErrorTitle;

  /// No description provided for @settingsOpenErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Please open iOS Settings manually and allow Photos access.'**
  String get settingsOpenErrorMessage;

  /// No description provided for @photoPickerNavTitle.
  ///
  /// In en, this message translates to:
  /// **'Photo Picker'**
  String get photoPickerNavTitle;

  /// No description provided for @photoPickerEmpty.
  ///
  /// In en, this message translates to:
  /// **'No photos found in your library.'**
  String get photoPickerEmpty;

  /// No description provided for @photoPickerReviewSelected.
  ///
  /// In en, this message translates to:
  /// **'Review {count} selected photo(s)'**
  String photoPickerReviewSelected(int count);

  /// No description provided for @photoPickerInstruction.
  ///
  /// In en, this message translates to:
  /// **'Select photos from your library to start review.'**
  String get photoPickerInstruction;

  /// No description provided for @photoPickerSelectPhotos.
  ///
  /// In en, this message translates to:
  /// **'Select Photos'**
  String get photoPickerSelectPhotos;

  /// No description provided for @photoPickerChangeSelection.
  ///
  /// In en, this message translates to:
  /// **'Change Selection'**
  String get photoPickerChangeSelection;

  /// No description provided for @photoPickerCancelled.
  ///
  /// In en, this message translates to:
  /// **'No photos selected.'**
  String get photoPickerCancelled;

  /// No description provided for @photoPickerFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open photo picker. Please try again.'**
  String get photoPickerFailed;

  /// No description provided for @swipeReviewNavTitle.
  ///
  /// In en, this message translates to:
  /// **'Swipe Review'**
  String get swipeReviewNavTitle;

  /// No description provided for @swipeReviewNoSelectedTitle.
  ///
  /// In en, this message translates to:
  /// **'No photos were selected.'**
  String get swipeReviewNoSelectedTitle;

  /// No description provided for @swipeReviewNoSelectedMessage.
  ///
  /// In en, this message translates to:
  /// **'Go back to Photo Picker and select photos first.'**
  String get swipeReviewNoSelectedMessage;

  /// No description provided for @swipeReviewBackToPicker.
  ///
  /// In en, this message translates to:
  /// **'Back to Photo Picker'**
  String get swipeReviewBackToPicker;

  /// No description provided for @swipeReviewKeptProgress.
  ///
  /// In en, this message translates to:
  /// **'{keptCount}/{maxCount} kept'**
  String swipeReviewKeptProgress(int keptCount, int maxCount);

  /// No description provided for @swipeReviewPhotoIndex.
  ///
  /// In en, this message translates to:
  /// **'Photo {index} / {total}'**
  String swipeReviewPhotoIndex(int index, int total);

  /// No description provided for @swipeReviewComplete.
  ///
  /// In en, this message translates to:
  /// **'Review complete'**
  String get swipeReviewComplete;

  /// No description provided for @swipeReviewCapturedAt.
  ///
  /// In en, this message translates to:
  /// **'Captured {value}'**
  String swipeReviewCapturedAt(String value);

  /// No description provided for @swipeReviewHint.
  ///
  /// In en, this message translates to:
  /// **'Swipe right to Keep, left to Skip'**
  String get swipeReviewHint;

  /// No description provided for @swipeReviewUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get swipeReviewUndo;

  /// No description provided for @swipeReviewSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get swipeReviewSkip;

  /// No description provided for @swipeReviewKeep.
  ///
  /// In en, this message translates to:
  /// **'Keep'**
  String get swipeReviewKeep;

  /// No description provided for @swipeDecisionKeepBadge.
  ///
  /// In en, this message translates to:
  /// **'KEEP'**
  String get swipeDecisionKeepBadge;

  /// No description provided for @swipeDecisionSkipBadge.
  ///
  /// In en, this message translates to:
  /// **'SKIP'**
  String get swipeDecisionSkipBadge;

  /// No description provided for @keptGridNavTitle.
  ///
  /// In en, this message translates to:
  /// **'Kept Grid'**
  String get keptGridNavTitle;

  /// No description provided for @keptGridEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No kept photos yet.'**
  String get keptGridEmptyTitle;

  /// No description provided for @keptGridEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Go back and keep up to 4 photos first.'**
  String get keptGridEmptyMessage;

  /// No description provided for @keptGridBackToPicker.
  ///
  /// In en, this message translates to:
  /// **'Back to Photo Picker'**
  String get keptGridBackToPicker;

  /// No description provided for @keptGridSummary.
  ///
  /// In en, this message translates to:
  /// **'{count} kept photo(s)'**
  String keptGridSummary(int count);

  /// No description provided for @keptGridReady.
  ///
  /// In en, this message translates to:
  /// **'Great. You are ready to choose a layout.'**
  String get keptGridReady;

  /// No description provided for @keptGridNeedExactly4.
  ///
  /// In en, this message translates to:
  /// **'You need exactly 4 kept photos to continue.'**
  String get keptGridNeedExactly4;

  /// No description provided for @keptGridProceedToLayout.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Layout'**
  String get keptGridProceedToLayout;

  /// No description provided for @keptGridRedoReview.
  ///
  /// In en, this message translates to:
  /// **'Redo Review'**
  String get keptGridRedoReview;

  /// No description provided for @keptGridKeepTag.
  ///
  /// In en, this message translates to:
  /// **'Keep {index}'**
  String keptGridKeepTag(int index);

  /// No description provided for @layoutSelectionNavTitle.
  ///
  /// In en, this message translates to:
  /// **'Layout Selection'**
  String get layoutSelectionNavTitle;

  /// No description provided for @layoutSelectionNeedExactly4Title.
  ///
  /// In en, this message translates to:
  /// **'Exactly 4 kept photos are required.'**
  String get layoutSelectionNeedExactly4Title;

  /// No description provided for @layoutSelectionNeedExactly4Message.
  ///
  /// In en, this message translates to:
  /// **'Go back and finish selection first.'**
  String get layoutSelectionNeedExactly4Message;

  /// No description provided for @layoutSelectionBackToKeptGrid.
  ///
  /// In en, this message translates to:
  /// **'Back to Kept Grid'**
  String get layoutSelectionBackToKeptGrid;

  /// No description provided for @layoutSelectionLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load layout preference.'**
  String get layoutSelectionLoadError;

  /// No description provided for @layoutSelectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your collage layout'**
  String get layoutSelectionTitle;

  /// No description provided for @layoutSelectionLastChoiceHint.
  ///
  /// In en, this message translates to:
  /// **'Your last choice is preselected.'**
  String get layoutSelectionLastChoiceHint;

  /// No description provided for @layoutSelectionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue to Export'**
  String get layoutSelectionContinue;

  /// No description provided for @layoutVerticalTitle.
  ///
  /// In en, this message translates to:
  /// **'1x4 Vertical'**
  String get layoutVerticalTitle;

  /// No description provided for @layoutVerticalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tall stack, story-friendly.'**
  String get layoutVerticalSubtitle;

  /// No description provided for @layoutGridTitle.
  ///
  /// In en, this message translates to:
  /// **'2x2 Grid'**
  String get layoutGridTitle;

  /// No description provided for @layoutGridSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Balanced square, feed-friendly.'**
  String get layoutGridSubtitle;

  /// No description provided for @exportNavTitle.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get exportNavTitle;

  /// No description provided for @exportNeedExactly4Title.
  ///
  /// In en, this message translates to:
  /// **'Exactly 4 photos are required for export.'**
  String get exportNeedExactly4Title;

  /// No description provided for @exportNeedExactly4Message.
  ///
  /// In en, this message translates to:
  /// **'Return to layout selection after choosing 4 kept photos.'**
  String get exportNeedExactly4Message;

  /// No description provided for @exportBackToLayoutSelection.
  ///
  /// In en, this message translates to:
  /// **'Back to Layout Selection'**
  String get exportBackToLayoutSelection;

  /// No description provided for @exportLoadSettingsError.
  ///
  /// In en, this message translates to:
  /// **'Could not load export settings.'**
  String get exportLoadSettingsError;

  /// No description provided for @exportLayoutLabel.
  ///
  /// In en, this message translates to:
  /// **'Layout: {layout}'**
  String exportLayoutLabel(String layout);

  /// No description provided for @exportCaptionPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Optional caption (single line)'**
  String get exportCaptionPlaceholder;

  /// No description provided for @exportNoPreview.
  ///
  /// In en, this message translates to:
  /// **'No render preview yet.\nTap Render Preview.'**
  String get exportNoPreview;

  /// No description provided for @exportRenderPreviewButton.
  ///
  /// In en, this message translates to:
  /// **'Render Preview ({preset})'**
  String exportRenderPreviewButton(String preset);

  /// No description provided for @exportSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get exportSave;

  /// No description provided for @exportShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get exportShare;

  /// No description provided for @exportStatusRendering.
  ///
  /// In en, this message translates to:
  /// **'Rendering collage...'**
  String get exportStatusRendering;

  /// No description provided for @exportStatusPreviewDone.
  ///
  /// In en, this message translates to:
  /// **'Preview rendered.'**
  String get exportStatusPreviewDone;

  /// No description provided for @exportStatusSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving to Photos...'**
  String get exportStatusSaving;

  /// No description provided for @exportStatusSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved to Photos.'**
  String get exportStatusSaved;

  /// No description provided for @exportStatusPreparingShare.
  ///
  /// In en, this message translates to:
  /// **'Preparing share sheet...'**
  String get exportStatusPreparingShare;

  /// No description provided for @exportStatusShared.
  ///
  /// In en, this message translates to:
  /// **'Share sheet opened.'**
  String get exportStatusShared;

  /// No description provided for @exportShareText.
  ///
  /// In en, this message translates to:
  /// **'Made with BestShot'**
  String get exportShareText;

  /// No description provided for @exportRenderFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Render failed'**
  String get exportRenderFailedTitle;

  /// No description provided for @exportRenderFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Could not render collage: {error}'**
  String exportRenderFailedMessage(String error);

  /// No description provided for @exportSaveFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Save failed'**
  String get exportSaveFailedTitle;

  /// No description provided for @exportSaveFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Could not save collage: {error}'**
  String exportSaveFailedMessage(String error);

  /// No description provided for @exportShareFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Share failed'**
  String get exportShareFailedTitle;

  /// No description provided for @exportShareFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Could not share collage: {error}'**
  String exportShareFailedMessage(String error);

  /// No description provided for @exportPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Photos permission required'**
  String get exportPermissionTitle;

  /// No description provided for @exportPermissionMessage.
  ///
  /// In en, this message translates to:
  /// **'BestShot needs permission to save exported images to your Photos.'**
  String get exportPermissionMessage;

  /// No description provided for @resetConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Start over?'**
  String get resetConfirmTitle;

  /// No description provided for @resetConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Current progress will be discarded and you will return to Photo Picker.'**
  String get resetConfirmMessage;

  /// No description provided for @collageNavTitle.
  ///
  /// In en, this message translates to:
  /// **'Collage'**
  String get collageNavTitle;

  /// No description provided for @collagePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Collage screen placeholder'**
  String get collagePlaceholder;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
