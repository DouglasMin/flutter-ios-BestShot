class SelectedPhoto {
  const SelectedPhoto({required this.id, required this.path});

  final String id;
  final String path;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedPhoto &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
