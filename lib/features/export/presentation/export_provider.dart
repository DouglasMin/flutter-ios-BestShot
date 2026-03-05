import 'dart:async';

import 'package:bestshot/core/collage/collage_types.dart';
import 'package:bestshot/core/constants/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'export_provider.g.dart';

@riverpod
class ExportSettingsController extends _$ExportSettingsController {
  @override
  FutureOr<ExportPreset> build() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(AppConstants.lastExportPresetKey);
    return ExportPresetX.fromStorageKey(stored);
  }

  void selectPreset(ExportPreset preset) {
    state = AsyncData(preset);
  }

  Future<void> persistSelectedPreset() async {
    final selected = state.valueOrNull;
    if (selected == null) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppConstants.lastExportPresetKey,
      selected.storageKey,
    );
  }
}
