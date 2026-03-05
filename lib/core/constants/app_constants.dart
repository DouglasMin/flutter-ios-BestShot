/// Global app-level constants.
/// Replace placeholder values before release.
abstract final class AppConstants {
  static const String appName = 'BestShot';
  static const String bundleId = 'com.douggy.bestshot';
  static const String onboardingCompletedKey = 'onboarding_completed';
  static const String lastLayoutSelectionKey = 'last_layout_selection';
  static const String lastExportPresetKey = 'last_export_preset';

  /// API
  static const String baseUrl = 'https://api.example.com'; // TODO: update
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
