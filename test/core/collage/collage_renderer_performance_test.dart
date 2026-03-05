import 'dart:ui' as ui;

import 'package:bestshot/core/collage/collage_renderer.dart';
import 'package:bestshot/core/collage/collage_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const runBenchmark = bool.fromEnvironment(
    'RUN_EXPORT_BENCHMARK',
    defaultValue: false,
  );

  group('CollageRenderer export benchmark', () {
    const maxAllowedMs = 5000;
    const renderer = CollageRenderer();
    var sourceImages = <ui.Image>[];

    setUpAll(() async {
      if (!runBenchmark) {
        return;
      }
      sourceImages = await Future.wait(
        <Future<ui.Image>>[
          _solidImage(width: 1200, height: 900, color: Colors.red),
          _solidImage(width: 900, height: 1200, color: Colors.blue),
          _solidImage(width: 1280, height: 854, color: Colors.green),
          _solidImage(width: 854, height: 1280, color: Colors.orange),
        ],
      );
    });

    tearDownAll(() {
      if (!runBenchmark) {
        return;
      }
      for (final image in sourceImages) {
        image.dispose();
      }
    });

    for (final layout in CollageLayoutType.values) {
      for (final preset in ExportPreset.values) {
        testWidgets('${layout.name} + ${preset.name} renders under 5 seconds', (
          tester,
        ) async {
          final stopwatch = Stopwatch()..start();

          final bytes = await renderer.renderFromImages(
            images: sourceImages,
            layout: layout,
            outputSize: preset.outputSize,
            caption: 'Performance benchmark',
          );

          stopwatch.stop();

          expect(bytes, isNotEmpty);
          expect(
            stopwatch.elapsedMilliseconds,
            lessThan(maxAllowedMs),
            reason:
                'Render took ${stopwatch.elapsedMilliseconds}ms for ${layout.name}/${preset.name}. '
                'Target is under ${maxAllowedMs}ms.',
          );
        }, skip: !runBenchmark);
      }
    }
  });
}

Future<ui.Image> _solidImage({
  required int width,
  required int height,
  required Color color,
}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  canvas.drawRect(
    Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    Paint()..color = color,
  );
  final picture = recorder.endRecording();
  final image = await picture.toImage(width, height);
  picture.dispose();
  return image;
}
