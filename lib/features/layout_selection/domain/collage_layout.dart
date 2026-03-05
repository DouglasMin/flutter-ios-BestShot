enum CollageLayout {
  vertical1x4,
  grid2x2,
}

extension CollageLayoutX on CollageLayout {
  String get storageKey {
    switch (this) {
      case CollageLayout.vertical1x4:
        return 'vertical_1x4';
      case CollageLayout.grid2x2:
        return 'grid_2x2';
    }
  }

  static CollageLayout fromStorageKey(String? value) {
    return CollageLayout.values.firstWhere(
      (layout) => layout.storageKey == value,
      orElse: () => CollageLayout.vertical1x4,
    );
  }
}
