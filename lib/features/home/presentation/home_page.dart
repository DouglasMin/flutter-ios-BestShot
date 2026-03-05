import 'package:bestshot/core/ui/adaptive_page_metrics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:bestshot/l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final metrics = AdaptivePageMetrics.of(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: Text(l10n.appName),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            const _BackgroundDecor(),
            Padding(
              padding: EdgeInsets.fromLTRB(
                metrics.horizontalPadding,
                metrics.topContentPadding,
                metrics.horizontalPadding,
                metrics.bottomContentPadding,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: metrics.contentMaxWidth,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.homeHeadline,
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                          letterSpacing: -0.8,
                        ),
                      ).animate().fadeIn(duration: 400.ms),
                      SizedBox(height: metrics.sectionGapSmall),
                      Text(
                        l10n.homeSubtitle,
                        style: const TextStyle(
                          fontSize: 15,
                          color: CupertinoColors.secondaryLabel,
                          height: 1.4,
                        ),
                      ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
                      SizedBox(height: metrics.sectionGapLarge),
                      _FeatureCard(
                            icon: CupertinoIcons.hand_draw_fill,
                            title: l10n.homeFeatureSwipeTitle,
                            subtitle: l10n.homeFeatureSwipeSubtitle,
                          )
                          .animate()
                          .fadeIn(delay: 200.ms, duration: 400.ms)
                          .slideY(
                            begin: 0.3,
                            duration: 400.ms,
                            curve: Curves.easeOutCubic,
                          ),
                      SizedBox(height: metrics.sectionGapSmall),
                      _FeatureCard(
                            icon: CupertinoIcons.square_grid_2x2_fill,
                            title: l10n.homeFeatureLayoutTitle,
                            subtitle: l10n.homeFeatureLayoutSubtitle,
                          )
                          .animate()
                          .fadeIn(delay: 350.ms, duration: 400.ms)
                          .slideY(
                            begin: 0.3,
                            duration: 400.ms,
                            curve: Curves.easeOutCubic,
                          ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton.filled(
                          onPressed: () => context.push('/photo-picker'),
                          child: Text(l10n.homeStartPicking),
                        ),
                      ),
                      SizedBox(height: metrics.sectionGapSmall * 0.66),
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                          onPressed: () => context.push(
                            '/onboarding-intro?next=/onboarding',
                          ),
                          child: Text(l10n.homeReplayOnboarding),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundDecor extends StatelessWidget {
  const _BackgroundDecor();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  CupertinoColors.systemBackground.resolveFrom(context),
                  CupertinoColors.systemGrey6.resolveFrom(context),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        Positioned(
          top: -70,
          right: -30,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: CupertinoColors.activeBlue.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 120,
          left: -50,
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: CupertinoColors.activeGreen.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground
            .resolveFrom(context)
            .withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: CupertinoColors.systemGrey4.resolveFrom(context),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: CupertinoColors.activeBlue.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 18, color: CupertinoColors.activeBlue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: CupertinoColors.secondaryLabel,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
