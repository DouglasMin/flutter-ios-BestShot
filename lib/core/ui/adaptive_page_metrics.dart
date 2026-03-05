import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class AdaptivePageMetrics {
  AdaptivePageMetrics._({
    required this.horizontalPadding,
    required this.contentMaxWidth,
    required this.topContentPadding,
    required this.bottomContentPadding,
    required this.sectionGapSmall,
    required this.sectionGapMedium,
    required this.sectionGapLarge,
  });

  final double horizontalPadding;
  final double contentMaxWidth;
  final double topContentPadding;
  final double bottomContentPadding;
  final double sectionGapSmall;
  final double sectionGapMedium;
  final double sectionGapLarge;

  static AdaptivePageMetrics of(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final viewPadding = mediaQuery.viewPadding;
    final shortestSide = math.min(size.width, size.height);

    final horizontalPadding = _clamp(shortestSide * 0.055, 18, 28);
    final contentMaxWidth = _clamp(size.width * 0.94, 320, 560);
    final topContentPadding = _clamp(viewPadding.top + 8, 8, 24);
    final bottomContentPadding = _clamp(viewPadding.bottom + 14, 14, 34);

    return AdaptivePageMetrics._(
      horizontalPadding: horizontalPadding,
      contentMaxWidth: contentMaxWidth,
      topContentPadding: topContentPadding,
      bottomContentPadding: bottomContentPadding,
      sectionGapSmall: _clamp(shortestSide * 0.02, 8, 16),
      sectionGapMedium: _clamp(shortestSide * 0.032, 12, 26),
      sectionGapLarge: _clamp(shortestSide * 0.05, 18, 36),
    );
  }

  static double _clamp(double value, double min, double max) {
    return value.clamp(min, max).toDouble();
  }
}
