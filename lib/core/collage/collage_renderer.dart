import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bestshot/core/collage/collage_types.dart';
import 'package:bestshot/core/collage/painters/grid_2x2_collage_painter.dart';
import 'package:bestshot/core/collage/painters/vertical_1x4_collage_painter.dart';
import 'package:bestshot/features/photo_picker/domain/selected_photo.dart';
import 'package:flutter/material.dart';

class CollageRenderer {
  const CollageRenderer();

  Future<Uint8List> renderFromPhotos({
    required List<SelectedPhoto> photos,
    required CollageLayoutType layout,
    required ExportPreset preset,
    String? caption,
    Color backgroundColor = Colors.white,
    double spacing = 12,
    double padding = 20,
  }) async {
    if (photos.length < 4) {
      throw ArgumentError('At least 4 photos are required.');
    }

    final decodedImages = <ui.Image>[];
    try {
      for (final photo in photos.take(4)) {
        final fileBytes = await File(photo.path).readAsBytes();
        decodedImages.add(await _decodeImage(fileBytes));
      }

      return renderFromImages(
        images: decodedImages,
        layout: layout,
        outputSize: preset.outputSize,
        caption: caption,
        backgroundColor: backgroundColor,
        spacing: spacing,
        padding: padding,
      );
    } finally {
      for (final image in decodedImages) {
        image.dispose();
      }
    }
  }

  Future<Uint8List> renderFromImages({
    required List<ui.Image> images,
    required CollageLayoutType layout,
    required Size outputSize,
    String? caption,
    Color backgroundColor = Colors.white,
    double spacing = 12,
    double padding = 20,
  }) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final backgroundPaint = Paint()..color = backgroundColor;
    canvas.drawRect(Offset.zero & outputSize, backgroundPaint);

    final normalizedCaption = caption?.trim() ?? '';
    final hasCaption = normalizedCaption.isNotEmpty;
    final captionStripHeight = hasCaption ? outputSize.height * 0.12 : 0.0;
    final usableRect = Rect.fromLTWH(
      0,
      0,
      outputSize.width,
      outputSize.height - captionStripHeight,
    );
    final collageRect = _fitContainedRect(
      bounds: usableRect,
      aspectRatio: _layoutAspectRatio(layout),
    );

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

    canvas.save();
    canvas.translate(collageRect.left, collageRect.top);
    painter.paint(canvas, collageRect.size);
    canvas.restore();

    if (hasCaption) {
      _drawCaption(
        canvas: canvas,
        caption: normalizedCaption,
        outputSize: outputSize,
        captionStripHeight: captionStripHeight,
      );
    }

    final picture = recorder.endRecording();
    final image = await picture.toImage(
      outputSize.width.toInt(),
      outputSize.height.toInt(),
    );
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    picture.dispose();

    if (byteData == null) {
      throw StateError('Failed to encode collage image bytes.');
    }
    return byteData.buffer.asUint8List();
  }

  Future<ui.Image> _decodeImage(Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    codec.dispose();
    return frame.image;
  }

  double _layoutAspectRatio(CollageLayoutType layout) {
    return switch (layout) {
      CollageLayoutType.vertical1x4 => 3 / 4,
      CollageLayoutType.grid2x2 => 1,
    };
  }

  Rect _fitContainedRect({
    required Rect bounds,
    required double aspectRatio,
  }) {
    final boundsRatio = bounds.width / bounds.height;

    if (boundsRatio > aspectRatio) {
      final height = bounds.height;
      final width = height * aspectRatio;
      final left = bounds.left + (bounds.width - width) / 2;
      return Rect.fromLTWH(left, bounds.top, width, height);
    }

    final width = bounds.width;
    final height = width / aspectRatio;
    final top = bounds.top + (bounds.height - height) / 2;
    return Rect.fromLTWH(bounds.left, top, width, height);
  }

  void _drawCaption({
    required Canvas canvas,
    required String caption,
    required Size outputSize,
    required double captionStripHeight,
  }) {
    final captionTop = outputSize.height - captionStripHeight;
    final textPainter = TextPainter(
      text: TextSpan(
        text: caption,
        style: TextStyle(
          color: Colors.black87,
          fontSize: outputSize.width * 0.04,
          fontWeight: FontWeight.w600,
          fontFamily: '.SF Pro Text',
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '...',
      textAlign: TextAlign.center,
    )..layout(maxWidth: outputSize.width - 64);

    final offset = Offset(
      (outputSize.width - textPainter.width) / 2,
      captionTop + (captionStripHeight - textPainter.height) / 2,
    );
    textPainter.paint(canvas, offset);
  }
}
