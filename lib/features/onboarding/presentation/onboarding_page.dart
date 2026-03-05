import 'package:bestshot/core/ui/adaptive_page_metrics.dart';
import 'package:bestshot/features/onboarding/presentation/onboarding_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bestshot/l10n/app_localizations.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  late final PageController _pageController;
  int _currentStepIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final metrics = AdaptivePageMetrics.of(context);
    final steps = _steps(l10n);
    final onboardingState = ref.watch(onboardingControllerProvider);
    final isSubmitting = onboardingState.isLoading;
    final isLastStep = _currentStepIndex == steps.length - 1;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: Text(l10n.onboardingNavTitle),
        trailing: !isLastStep
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: isSubmitting ? null : _finishOnboarding,
                child: Text(l10n.onboardingSkip),
              )
            : null,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: steps.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentStepIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final step = steps[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: metrics.horizontalPadding,
                      vertical: metrics.sectionGapMedium,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: metrics.contentMaxWidth,
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                      step.icon,
                                      size: 72,
                                      color: CupertinoColors.activeBlue,
                                    )
                                    .animate(key: ValueKey('icon_$index'))
                                    .scale(
                                      begin: const Offset(0.8, 0.8),
                                      end: const Offset(1, 1),
                                      duration: 400.ms,
                                      curve: Curves.easeOutBack,
                                    )
                                    .fadeIn(duration: 400.ms),
                                SizedBox(height: metrics.sectionGapMedium),
                                Text(
                                      step.title,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                    .animate(key: ValueKey('title_$index'))
                                    .fadeIn(delay: 100.ms, duration: 350.ms)
                                    .slideY(
                                      begin: 0.2,
                                      duration: 350.ms,
                                      curve: Curves.easeOut,
                                    ),
                                SizedBox(height: metrics.sectionGapSmall),
                                Text(
                                      step.description,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: CupertinoColors.secondaryLabel,
                                      ),
                                    )
                                    .animate(key: ValueKey('desc_$index'))
                                    .fadeIn(delay: 180.ms, duration: 350.ms),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                steps.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentStepIndex == index ? 18 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentStepIndex == index
                        ? CupertinoColors.activeBlue
                        : CupertinoColors.systemGrey3,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
            ),
            SizedBox(height: metrics.sectionGapMedium),
            Padding(
              padding: EdgeInsets.fromLTRB(
                metrics.horizontalPadding,
                0,
                metrics.horizontalPadding,
                metrics.bottomContentPadding,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: metrics.contentMaxWidth,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      onPressed: isSubmitting
                          ? null
                          : isLastStep
                          ? _finishOnboarding
                          : _goToNextStep,
                      child: isSubmitting
                          ? const CupertinoActivityIndicator(
                              color: CupertinoColors.white,
                            )
                          : Text(
                              isLastStep
                                  ? l10n.onboardingAllowContinue
                                  : l10n.onboardingNext,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToNextStep() async {
    final nextIndex = _currentStepIndex + 1;
    if (nextIndex >= _stepCount) {
      return;
    }
    await _pageController.animateToPage(
      nextIndex,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  Future<void> _finishOnboarding() async {
    final l10n = AppLocalizations.of(context);
    try {
      await ref
          .read(onboardingControllerProvider.notifier)
          .completeOnboarding();
      if (!mounted) {
        return;
      }
      context.go('/');
    } catch (_) {
      if (!mounted) {
        return;
      }
      await showCupertinoDialog<void>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(l10n.onboardingErrorTitle),
          content: Text(l10n.onboardingErrorMessage),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.commonOk),
            ),
          ],
        ),
      );
    }
  }

  int get _stepCount => 3;

  List<({IconData icon, String title, String description})> _steps(
    AppLocalizations l10n,
  ) {
    return [
      (
        icon: CupertinoIcons.photo_on_rectangle,
        title: l10n.onboardingStep1Title,
        description: l10n.onboardingStep1Description,
      ),
      (
        icon: CupertinoIcons.hand_draw,
        title: l10n.onboardingStep2Title,
        description: l10n.onboardingStep2Description,
      ),
      (
        icon: CupertinoIcons.square_on_square,
        title: l10n.onboardingStep3Title,
        description: l10n.onboardingStep3Description,
      ),
    ];
  }
}
