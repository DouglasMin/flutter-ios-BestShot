import 'dart:ui' as ui;

import 'package:flutter/material.dart';

final class CollagePainterUtils {
  const CollagePainterUtils._();

  static void drawCoverImage({
    required Canvas canvas,
    required ui.Image image,
    required Rect destinationRect,
    Paint? paint,
  }) {
    final sourceRect = _sourceRectForCover(
      imageSize: Size(
        image.width.toDouble(),
        image.height.toDouble(),
      ),
      destinationRect: destinationRect,
    );
    canvas.drawImageRect(
      image,
      sourceRect,
      destinationRect,
      paint ?? Paint()..isAntiAlias = true,
    );
  }

  static Rect _sourceRectForCover({
    required Size imageSize,
    required Rect destinationRect,
  }) {
    final imageRatio = imageSize.width / imageSize.height;
    final destinationRatio = destinationRect.width / destinationRect.height;

    if (imageRatio > destinationRatio) {
      final sourceHeight = imageSize.height;
      final sourceWidth = sourceHeight * destinationRatio;
      final left = (imageSize.width - sourceWidth) / 2;
      return Rect.fromLTWH(left, 0, sourceWidth, sourceHeight);
    }

    final sourceWidth = imageSize.width;
    final sourceHeight = sourceWidth / destinationRatio;
    final top = (imageSize.height - sourceHeight) / 2;
    return Rect.fromLTWH(0, top, sourceWidth, sourceHeight);
  }
}
