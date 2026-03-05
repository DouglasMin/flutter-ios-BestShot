import 'package:bestshot/core/ui/adaptive_page_metrics.dart';
import 'dart:ui';

import 'package:bestshot/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class OnboardingIntroPage extends StatelessWidget {
  const OnboardingIntroPage({super.key, this.nextPath = '/onboarding'});

  final String nextPath;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final metrics = AdaptivePageMetrics.of(context);

    return CupertinoPageScaffold(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFEAF2FF), Color(0xFFF8FAFF), Color(0xFFFFFFFF)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -90,
              left: -36,
              child: Container(
                width: 210,
                height: 210,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: -70,
              right: -24,
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  color: const Color(0xFF5FA8FF).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  metrics.horizontalPadding,
                  metrics.topContentPadding,
                  metrics.horizontalPadding,
                  metrics.bottomContentPadding,
                ),
                child: Column(
                  children: [
                    ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: metrics.contentMaxWidth,
                          ),
                          child: _HeroCard(
                            title: l10n.onboardingIntroTitle,
                            subtitle: l10n.onboardingIntroSubtitle,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 450.ms)
                        .slideY(
                          begin: 0.08,
                          end: 0,
                          duration: 450.ms,
                          curve: Curves.easeOutCubic,
                        ),
                    SizedBox(height: metrics.sectionGapSmall),
                    Text(
                      l10n.onboardingIntroCaption,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: CupertinoColors.secondaryLabel,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ).animate().fadeIn(delay: 180.ms, duration: 350.ms),
                    const Spacer(),
                    ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: metrics.contentMaxWidth,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: CupertinoButton.filled(
                              onPressed: () => context.go(nextPath),
                              child: Text(l10n.onboardingIntroStart),
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 230.ms, duration: 300.ms)
                        .slideY(
                          begin: 0.2,
                          end: 0,
                          duration: 350.ms,
                          curve: Curves.easeOut,
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xCCFFFFFF),
            border: Border.all(color: const Color(0x33FFFFFF), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 30,
                offset: Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            children: [
              const _AnimatedLogoPill(),
              const SizedBox(height: 22),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  color: CupertinoColors.secondaryLabel,
                  height: 1.32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedLogoPill extends StatelessWidget {
  const _AnimatedLogoPill();

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 88,
          height: 88,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF5FA8FF), Color(0xFF3B82F6)],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x33446EE5),
                blurRadius: 22,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: const Icon(
            CupertinoIcons.sparkles,
            color: CupertinoColors.white,
            size: 44,
          ),
        )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scaleXY(
          begin: 1,
          end: 1.05,
          duration: 1600.ms,
          curve: Curves.easeInOut,
        )
        .shimmer(duration: 1800.ms, color: const Color(0xAAFFFFFF));
  }
}
