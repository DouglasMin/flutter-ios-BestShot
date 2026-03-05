import 'package:flutter/widgets.dart';

enum CollageLayoutType {
  vertical1x4,
  grid2x2,
}

enum ExportPreset {
  ratio4x5,
  square1x1,
  ratio9x16,
}

extension ExportPresetX on ExportPreset {
  String get storageKey {
    switch (this) {
      case ExportPreset.ratio4x5:
        return 'ratio_4x5';
      case ExportPreset.square1x1:
        return 'square_1x1';
      case ExportPreset.ratio9x16:
        return 'ratio_9x16';
    }
  }

  String get displayName {
    switch (this) {
      case ExportPreset.ratio4x5:
        return '4:5 (1080x1350)';
      case ExportPreset.square1x1:
        return '1:1 (1080x1080)';
      case ExportPreset.ratio9x16:
        return '9:16 (1080x1920)';
    }
  }

  Size get outputSize {
    switch (this) {
      case ExportPreset.ratio4x5:
        return const Size(1080, 1350);
      case ExportPreset.square1x1:
        return const Size(1080, 1080);
      case ExportPreset.ratio9x16:
        return const Size(1080, 1920);
    }
  }

  static ExportPreset fromStorageKey(String? value) {
    return ExportPreset.values.firstWhere(
      (preset) => preset.storageKey == value,
      orElse: () => ExportPreset.ratio4x5,
    );
  }
}
