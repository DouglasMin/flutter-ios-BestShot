import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:home_widget/home_widget.dart';

class HomeScreenWidgetService {
  const HomeScreenWidgetService._();

  static const String appGroupId = 'group.com.douggy.bestshot';
  static const String iOSWidgetKind = 'BestShotHomeWidget';

  static const String imagePathKey = 'bestshot_widget_image_path';
  static const String captionKey = 'bestshot_widget_caption';
  static const String layoutKey = 'bestshot_widget_layout';
  static const String presetKey = 'bestshot_widget_preset';
  static const String updatedAtKey = 'bestshot_widget_updated_at';
  static const Size _widgetRenderSize = Size(600, 600);

  static bool _initialized = false;

  static Future<void> initialize() async {
    if (!Platform.isIOS || _initialized) {
      return;
    }
    await HomeWidget.setAppGroupId(appGroupId);
    _initialized = true;
  }

  static Future<void> syncLatestExport({
    required Uint8List imageBytes,
    required String caption,
    required String layout,
    required String preset,
  }) async {
    if (!Platform.isIOS) {
      return;
    }

    await initialize();
    await HomeWidget.saveWidgetData<String>(captionKey, caption);
    await HomeWidget.saveWidgetData<String>(layoutKey, layout);
    await HomeWidget.saveWidgetData<String>(presetKey, preset);
    await HomeWidget.saveWidgetData<String>(
      updatedAtKey,
      DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
    );

    // This writes the image into the App Group container and stores its path.
    await HomeWidget.renderFlutterWidget(
      SizedBox.fromSize(
        size: _widgetRenderSize,
        child: ClipRect(
          child: Image.memory(
            imageBytes,
            width: _widgetRenderSize.width,
            height: _widgetRenderSize.height,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.medium,
          ),
        ),
      ),
      key: imagePathKey,
      logicalSize: _widgetRenderSize,
      pixelRatio: 1,
    );

    await HomeWidget.updateWidget(iOSName: iOSWidgetKind);
  }
}
