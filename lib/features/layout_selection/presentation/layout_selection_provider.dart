import 'dart:async';

import 'package:bestshot/core/constants/app_constants.dart';
import 'package:bestshot/features/layout_selection/domain/collage_layout.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'layout_selection_provider.g.dart';

@riverpod
class LayoutSelectionController extends _$LayoutSelectionController {
  @override
  FutureOr<CollageLayout> build() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(AppConstants.lastLayoutSelectionKey);
    return CollageLayoutX.fromStorageKey(stored);
  }

  void select(CollageLayout layout) {
    state = AsyncData(layout);
  }

  Future<void> persistSelection() async {
    final selected = state.valueOrNull;
    if (selected == null) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppConstants.lastLayoutSelectionKey,
      selected.storageKey,
    );
  }
}
