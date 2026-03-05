import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bestshot/core/collage/collage_types.dart';
import 'package:bestshot/core/collage/painters/grid_2x2_collage_painter.dart';
import 'package:bestshot/core/collage/painters/vertical_1x4_collage_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CollageRepaintBoundary extends StatelessWidget {
  const CollageRepaintBoundary({
    super.key,
    required this.boundaryKey,
    required this.images,
    required this.layout,
    required this.size,
    this.backgroundColor = Colors.white,
    this.spacing = 12,
    this.padding = 20,
  });

  final GlobalKey boundaryKey;
  final List<ui.Image> images;
  final CollageLayoutType layout;
  final Size size;
  final Color backgroundColor;
  final double spacing;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final painter = switch (layout) {
      CollageLayoutType.vertical1x4 => Vertical1x4CollagePainter(
          images: images,
          backgroundColor: backgroundColor,
          spacing: spacing,
          padding: padding,
        ),
      CollageLayoutType.grid2x2 => Grid2x2CollagePainter(
          images: images,
          backgroundColor: backgroundColor,
          spacing: spacing,
          padding: padding,
        ),
    };

    return RepaintBoundary(
      key: boundaryKey,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: CustomPaint(
          size: size,
          painter: painter,
        ),
      ),
    );
  }
}

Future<Uint8List> captureCollageFromBoundary({
  required GlobalKey boundaryKey,
  double pixelRatio = 1,
}) async {
  final context = boundaryKey.currentContext;
  if (context == null) {
    throw StateError('Collage boundary context is not attached.');
  }

  final renderObject = context.findRenderObject();
  if (renderObject is! RenderRepaintBoundary) {
    throw StateError('Boundary key is not attached to a RenderRepaintBoundary.');
  }

  final image = await renderObject.toImage(pixelRatio: pixelRatio);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  image.dispose();

  if (byteData == null) {
    throw StateError('Failed to capture collage bytes from RepaintBoundary.');
  }

  return byteData.buffer.asUint8List();
}
