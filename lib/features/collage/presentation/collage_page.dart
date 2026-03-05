import 'package:flutter/cupertino.dart';
import 'package:bestshot/l10n/app_localizations.dart';

class CollagePage extends StatelessWidget {
  const CollagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: false,
        middle: Text(l10n.collageNavTitle),
      ),
      child: SafeArea(child: Center(child: Text(l10n.collagePlaceholder))),
    );
  }
}
