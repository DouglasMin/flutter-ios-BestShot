import 'package:flutter/cupertino.dart';

/// iOS-native scaffold using [CupertinoPageScaffold] + [CupertinoNavigationBar].
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
  });

  final Widget body;
  final String? title;
  final Widget? leading;
  final Widget? trailing;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      navigationBar: title != null
          ? CupertinoNavigationBar(
              transitionBetweenRoutes: false,
              middle: Text(title!),
              leading: leading,
              trailing: trailing,
            )
          : null,
      child: SafeArea(child: body),
    );
  }
}
