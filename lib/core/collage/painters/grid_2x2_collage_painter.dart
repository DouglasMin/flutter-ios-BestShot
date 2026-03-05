import 'dart:ui' as ui;

import 'package:bestshot/core/collage/painters/collage_painter_utils.dart';
import 'package:flutter/material.dart';

class Grid2x2CollagePainter extends CustomPainter {
  Grid2x2CollagePainter({
    required this.images,
    this.backgroundColor = Colors.white,
    this.spacing = 12,
    this.padding = 20,
  });

  final List<ui.Image> images;
  final Color backgroundColor;
  final double spacing;
  final double padding;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = backgroundColor;
    canvas.drawRect(Offset.zero & size, backgroundPaint);

    final cellWidth = (size.width - (padding * 2) - spacing) / 2;
    final cellHeight = (size.height - (padding * 2) - spacing) / 2;
    final placeholderPaint = Paint()
      ..color = Colors.grey.shade300
      ..isAntiAlias = true;

    for (var index = 0; index < 4; index++) {
      final row = index ~/ 2;
      final column = index % 2;
      final left = padding + column * (cellWidth + spacing);
      final top = padding + row * (cellHeight + spacing);
      final destinationRect = Rect.fromLTWH(left, top, cellWidth, cellHeight);

      if (index >= images.length) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(destinationRect, const Radius.circular(8)),
          placeholderPaint,
        );
        continue;
      }

      canvas.save();
      canvas.clipRRect(
        RRect.fromRectAndRadius(destinationRect, const Radius.circular(8)),
      );
      CollagePainterUtils.drawCoverImage(
        canvas: canvas,
        image: images[index],
        destinationRect: destinationRect,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant Grid2x2CollagePainter oldDelegate) {
    return oldDelegate.images != images ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.spacing != spacing ||
        oldDelegate.padding != padding;
  }
}
