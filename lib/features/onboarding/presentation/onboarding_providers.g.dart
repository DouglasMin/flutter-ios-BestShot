// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isFirstLaunchHash() => r'10d954cf1bcf90d4c2356c51d53a562c237156d6';

/// See also [isFirstLaunch].
@ProviderFor(isFirstLaunch)
final isFirstLaunchProvider = AutoDisposeFutureProvider<bool>.internal(
  isFirstLaunch,
  name: r'isFirstLaunchProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isFirstLaunchHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsFirstLaunchRef = AutoDisposeFutureProviderRef<bool>;
String _$onboardingControllerHash() =>
    r'0fc7886a0370e80935b26dbd716283a840228c2d';

/// See also [OnboardingController].
@ProviderFor(OnboardingController)
final onboardingControllerProvider =
    AutoDisposeAsyncNotifierProvider<OnboardingController, void>.internal(
      OnboardingController.new,
      name: r'onboardingControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$onboardingControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$OnboardingController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
