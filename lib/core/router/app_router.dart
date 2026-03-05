import 'package:bestshot/features/collage/presentation/collage_page.dart';
import 'package:bestshot/features/export/presentation/export_page.dart';
import 'package:bestshot/features/home/presentation/home_page.dart';
import 'package:bestshot/features/kept_grid/presentation/kept_grid_page.dart';
import 'package:bestshot/features/layout_selection/presentation/layout_selection_page.dart';
import 'package:bestshot/features/onboarding/presentation/onboarding_gate_page.dart';
import 'package:bestshot/features/onboarding/presentation/onboarding_intro_page.dart';
import 'package:bestshot/features/onboarding/presentation/onboarding_page.dart';
import 'package:bestshot/features/photo_picker/domain/selected_photo.dart';
import 'package:bestshot/features/photo_picker/presentation/photo_picker_page.dart';
import 'package:bestshot/features/swipe_review/presentation/swipe_review_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/launch',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/launch',
      name: 'launch',
      builder: (context, state) => const OnboardingGatePage(),
    ),
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/onboarding-intro',
      name: 'onboardingIntro',
      builder: (context, state) => OnboardingIntroPage(
        nextPath: state.uri.queryParameters['next'] ?? '/onboarding',
      ),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 420),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        child: const OnboardingPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          );
          final slide = Tween<Offset>(
            begin: const Offset(0.14, 0),
            end: Offset.zero,
          ).animate(curved);
          final fade = Tween<double>(begin: 0.2, end: 1).animate(curved);
          final outgoingParallax =
              Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(-0.05, 0),
              ).animate(
                CurvedAnimation(
                  parent: secondaryAnimation,
                  curve: Curves.easeOut,
                  reverseCurve: Curves.easeIn,
                ),
              );

          return SlideTransition(
            position: outgoingParallax,
            child: FadeTransition(
              opacity: fade,
              child: SlideTransition(position: slide, child: child),
            ),
          );
        },
      ),
    ),
    GoRoute(
      path: '/photo-picker',
      name: 'photoPicker',
      builder: (context, state) => const PhotoPickerPage(),
    ),
    GoRoute(
      path: '/swipe-review',
      name: 'swipeReview',
      builder: (context, state) {
        final extra = state.extra;
        final photos = extra is List<SelectedPhoto>
            ? extra
            : const <SelectedPhoto>[];
        return SwipeReviewPage(selectedPhotos: photos);
      },
    ),
    GoRoute(
      path: '/kept-grid',
      name: 'keptGrid',
      builder: (context, state) {
        final extra = state.extra;
        final photos = extra is List<SelectedPhoto>
            ? extra
            : const <SelectedPhoto>[];
        return KeptGridPage(keptPhotos: photos);
      },
    ),
    GoRoute(
      path: '/layout-selection',
      name: 'layoutSelection',
      builder: (context, state) {
        final extra = state.extra;
        final photos = extra is List<SelectedPhoto>
            ? extra
            : const <SelectedPhoto>[];
        return LayoutSelectionPage(keptPhotos: photos);
      },
    ),
    GoRoute(
      path: '/export',
      name: 'export',
      builder: (context, state) {
        final extra = state.extra;
        if (extra is Map<String, dynamic>) {
          final photos = extra['assets'];
          final layout = extra['layout'];
          return ExportPage(
            selectedPhotos: photos is List<SelectedPhoto>
                ? photos
                : const <SelectedPhoto>[],
            selectedLayoutKey: layout is String ? layout : null,
          );
        }
        return const ExportPage();
      },
    ),
    GoRoute(
      path: '/collage',
      name: 'collage',
      builder: (context, state) => const CollagePage(),
    ),
  ],
);
