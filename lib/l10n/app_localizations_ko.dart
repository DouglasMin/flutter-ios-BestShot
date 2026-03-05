// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appName => 'BestShot';

  @override
  String get commonRetry => '다시 시도';

  @override
  String get commonOk => '확인';

  @override
  String get commonCancel => '취소';

  @override
  String get commonStartOver => '처음부터';

  @override
  String get commonOpenSettings => '설정 열기';

  @override
  String get commonLoading => '불러오는 중...';

  @override
  String get homeHeadline => '오늘의 베스트컷\n4장만 고르세요.';

  @override
  String get homeSubtitle => '스와이프로 빠르게 고르고, 깔끔한 콜라주로 바로 저장하세요.';

  @override
  String get homeFeatureSwipeTitle => '빠른 스와이프 선별';

  @override
  String get homeFeatureSwipeSubtitle => '오른쪽은 보관, 왼쪽은 건너뛰기';

  @override
  String get homeFeatureLayoutTitle => '자동 레이아웃';

  @override
  String get homeFeatureLayoutSubtitle => '1x4 또는 2x2를 바로 선택';

  @override
  String get homeStartPicking => '사진 고르기 시작';

  @override
  String get homeReplayOnboarding => '온보딩 다시 보기';

  @override
  String get onboardingGatePreparing => 'BestShot 준비 중...';

  @override
  String get onboardingGateLoadError => '온보딩 상태를 불러오지 못했어요.';

  @override
  String get onboardingIntroTitle => '베스트컷 4장, 바로 완성.';

  @override
  String get onboardingIntroSubtitle =>
      '고른 사진을 빠르게 넘기며 핵심만 남기고, 몇 초 만에 깔끔한 콜라주로 저장하세요.';

  @override
  String get onboardingIntroCaption => '매일 빠른 선별을 위해 설계했어요.';

  @override
  String get onboardingIntroStart => '작동 방식 보기';

  @override
  String get onboardingNavTitle => 'BestShot 시작하기';

  @override
  String get onboardingSkip => '건너뛰기';

  @override
  String get onboardingStep1Title => '사진 고르기';

  @override
  String get onboardingStep1Description => '앨범에서 검토할 사진을 먼저 선택하세요.';

  @override
  String get onboardingStep2Title => '스와이프로 선별';

  @override
  String get onboardingStep2Description => '마음에 드는 사진은 보관하고, 최대 4장까지 추려요.';

  @override
  String get onboardingStep3Title => '콜라주로 내보내기';

  @override
  String get onboardingStep3Description => '레이아웃을 고르고 캡션과 함께 바로 저장하거나 공유해요.';

  @override
  String get onboardingAllowContinue => '시작하기';

  @override
  String get onboardingNext => '다음';

  @override
  String get onboardingErrorTitle => '문제가 발생했어요';

  @override
  String get onboardingErrorMessage => '온보딩을 완료하지 못했습니다. 다시 시도해 주세요.';

  @override
  String get settingsOpenErrorTitle => '설정을 열 수 없어요';

  @override
  String get settingsOpenErrorMessage => 'iOS 설정 앱을 직접 열어 사진 접근 권한을 허용해 주세요.';

  @override
  String get photoPickerNavTitle => '사진 선택';

  @override
  String get photoPickerEmpty => '앨범에 사진이 없어요.';

  @override
  String photoPickerReviewSelected(int count) {
    return '선택한 $count장 검토하기';
  }

  @override
  String get photoPickerInstruction => '앨범에서 사진을 선택해 검토를 시작하세요.';

  @override
  String get photoPickerSelectPhotos => '사진 선택';

  @override
  String get photoPickerChangeSelection => '선택 다시 하기';

  @override
  String get photoPickerCancelled => '선택된 사진이 없어요.';

  @override
  String get photoPickerFailed => '사진 선택기를 열지 못했어요. 다시 시도해 주세요.';

  @override
  String get swipeReviewNavTitle => '스와이프 검토';

  @override
  String get swipeReviewNoSelectedTitle => '선택된 사진이 없어요.';

  @override
  String get swipeReviewNoSelectedMessage => '사진 선택 화면으로 돌아가서 먼저 사진을 골라주세요.';

  @override
  String get swipeReviewBackToPicker => '사진 선택으로 이동';

  @override
  String swipeReviewKeptProgress(int keptCount, int maxCount) {
    return '$keptCount/$maxCount 보관됨';
  }

  @override
  String swipeReviewPhotoIndex(int index, int total) {
    return '사진 $index / $total';
  }

  @override
  String get swipeReviewComplete => '검토 완료';

  @override
  String swipeReviewCapturedAt(String value) {
    return '촬영 시각 $value';
  }

  @override
  String get swipeReviewHint => '오른쪽 스와이프는 보관, 왼쪽 스와이프는 건너뛰기';

  @override
  String get swipeReviewUndo => '되돌리기';

  @override
  String get swipeReviewSkip => '건너뛰기';

  @override
  String get swipeReviewKeep => '보관';

  @override
  String get swipeDecisionKeepBadge => '보관';

  @override
  String get swipeDecisionSkipBadge => '건너뜀';

  @override
  String get keptGridNavTitle => '보관한 사진';

  @override
  String get keptGridEmptyTitle => '아직 보관한 사진이 없어요.';

  @override
  String get keptGridEmptyMessage => '이전 단계로 돌아가 사진을 최대 4장 보관해 주세요.';

  @override
  String get keptGridBackToPicker => '사진 선택으로 이동';

  @override
  String keptGridSummary(int count) {
    return '보관 $count장';
  }

  @override
  String get keptGridReady => '좋아요. 이제 레이아웃을 선택할 수 있어요.';

  @override
  String get keptGridNeedExactly4 => '다음 단계로 가려면 정확히 4장이 필요해요.';

  @override
  String get keptGridProceedToLayout => '레이아웃 선택으로';

  @override
  String get keptGridRedoReview => '다시 고르기';

  @override
  String keptGridKeepTag(int index) {
    return '보관 $index';
  }

  @override
  String get layoutSelectionNavTitle => '레이아웃 선택';

  @override
  String get layoutSelectionNeedExactly4Title => '정확히 4장의 보관 사진이 필요해요.';

  @override
  String get layoutSelectionNeedExactly4Message => '이전 단계에서 4장을 먼저 선택해 주세요.';

  @override
  String get layoutSelectionBackToKeptGrid => '보관한 사진으로';

  @override
  String get layoutSelectionLoadError => '레이아웃 설정을 불러오지 못했어요.';

  @override
  String get layoutSelectionTitle => '콜라주 레이아웃을 선택하세요';

  @override
  String get layoutSelectionLastChoiceHint => '마지막으로 사용한 레이아웃이 선택되어 있어요.';

  @override
  String get layoutSelectionContinue => '내보내기 화면으로';

  @override
  String get layoutVerticalTitle => '1x4 세로형';

  @override
  String get layoutVerticalSubtitle => '스토리용으로 잘 맞는 세로 스택';

  @override
  String get layoutGridTitle => '2x2 그리드';

  @override
  String get layoutGridSubtitle => '피드용으로 깔끔한 정사각형 배치';

  @override
  String get exportNavTitle => '내보내기';

  @override
  String get exportNeedExactly4Title => '내보내려면 사진이 정확히 4장 필요해요.';

  @override
  String get exportNeedExactly4Message => '4장을 고른 뒤 레이아웃 선택 화면으로 돌아가 주세요.';

  @override
  String get exportBackToLayoutSelection => '레이아웃 선택으로';

  @override
  String get exportLoadSettingsError => '내보내기 설정을 불러오지 못했어요.';

  @override
  String exportLayoutLabel(String layout) {
    return '레이아웃: $layout';
  }

  @override
  String get exportCaptionPlaceholder => '캡션 입력 (선택)';

  @override
  String get exportNoPreview => '아직 미리보기가 없어요.\n미리보기 렌더링을 눌러주세요.';

  @override
  String exportRenderPreviewButton(String preset) {
    return '미리보기 렌더링 ($preset)';
  }

  @override
  String get exportSave => '저장';

  @override
  String get exportShare => '공유';

  @override
  String get exportStatusRendering => '콜라주를 렌더링하는 중...';

  @override
  String get exportStatusPreviewDone => '미리보기를 생성했어요.';

  @override
  String get exportStatusSaving => '사진 앱에 저장하는 중...';

  @override
  String get exportStatusSaved => '사진 앱에 저장했어요.';

  @override
  String get exportStatusPreparingShare => '공유 시트를 준비하는 중...';

  @override
  String get exportStatusShared => '공유 시트를 열었어요.';

  @override
  String get exportShareText => 'BestShot으로 만든 콜라주';

  @override
  String get exportRenderFailedTitle => '렌더링 실패';

  @override
  String exportRenderFailedMessage(String error) {
    return '콜라주를 렌더링하지 못했습니다: $error';
  }

  @override
  String get exportSaveFailedTitle => '저장 실패';

  @override
  String exportSaveFailedMessage(String error) {
    return '콜라주를 저장하지 못했습니다: $error';
  }

  @override
  String get exportShareFailedTitle => '공유 실패';

  @override
  String exportShareFailedMessage(String error) {
    return '콜라주를 공유하지 못했습니다: $error';
  }

  @override
  String get exportPermissionTitle => '사진 권한이 필요해요';

  @override
  String get exportPermissionMessage => '내보낸 이미지를 사진 앱에 저장하려면 접근 권한이 필요합니다.';

  @override
  String get resetConfirmTitle => '처음부터 다시 할까요?';

  @override
  String get resetConfirmMessage => '현재 진행 내용이 사라지고 사진 선택 화면으로 이동합니다.';

  @override
  String get collageNavTitle => '콜라주';

  @override
  String get collagePlaceholder => '콜라주 화면 준비 중';
}
