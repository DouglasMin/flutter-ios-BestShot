import 'dart:async';

import 'package:bestshot/core/constants/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_providers.g.dart';

@riverpod
Future<bool> isFirstLaunch(IsFirstLaunchRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  final completed =
      prefs.getBool(AppConstants.onboardingCompletedKey) ?? false;
  return !completed;
}

@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  FutureOr<void> build() {}

  Future<void> completeOnboarding() async {
    state = const AsyncLoading();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.onboardingCompletedKey, true);
      ref.invalidate(isFirstLaunchProvider);
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }
}
