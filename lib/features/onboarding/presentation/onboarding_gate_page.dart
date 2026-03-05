import 'package:bestshot/features/onboarding/presentation/onboarding_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bestshot/l10n/app_localizations.dart';

class OnboardingGatePage extends ConsumerStatefulWidget {
  const OnboardingGatePage({super.key});

  @override
  ConsumerState<OnboardingGatePage> createState() => _OnboardingGatePageState();
}

class _OnboardingGatePageState extends ConsumerState<OnboardingGatePage> {
  String? _lastTargetPath;

  @override
  Widget build(BuildContext context) {
    final firstLaunchAsync = ref.watch(isFirstLaunchProvider);

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: firstLaunchAsync.when(
            loading: _buildLoading,
            error: (error, _) => _buildError(context),
            data: (isFirstLaunch) {
              final targetPath = Uri(
                path: '/onboarding-intro',
                queryParameters: {'next': isFirstLaunch ? '/onboarding' : '/'},
              ).toString();
              if (_lastTargetPath != targetPath) {
                _lastTargetPath = targetPath;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) {
                    return;
                  }
                  context.go(targetPath);
                });
              }
              return _buildLoading();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CupertinoActivityIndicator(radius: 14),
            const SizedBox(height: 12),
            Text(l10n.onboardingGatePreparing),
          ],
        );
      },
    );
  }

  Widget _buildError(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(l10n.onboardingGateLoadError),
        const SizedBox(height: 12),
        CupertinoButton.filled(
          onPressed: () => ref.invalidate(isFirstLaunchProvider),
          child: Text(l10n.commonRetry),
        ),
      ],
    );
  }
}
