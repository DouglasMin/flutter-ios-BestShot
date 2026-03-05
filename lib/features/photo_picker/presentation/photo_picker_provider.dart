import 'package:bestshot/features/photo_picker/domain/selected_photo.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photo_picker_provider.g.dart';

enum PhotoPickResult {
  selected,
  cancelled,
  failed,
}

@riverpod
class PhotoPickerController extends _$PhotoPickerController {
  @override
  List<SelectedPhoto> build() => const <SelectedPhoto>[];

  Future<PhotoPickResult> pickPhotos() async {
    final picker = ImagePicker();
    try {
      final files = await picker.pickMultiImage();
      if (files.isEmpty) {
        return PhotoPickResult.cancelled;
      }

      final photos = files.map((file) {
        return SelectedPhoto(id: file.path, path: file.path);
      }).toList(growable: false);

      state = photos;
      return PhotoPickResult.selected;
    } on PlatformException {
      return PhotoPickResult.failed;
    }
  }

  void clearSelection() {
    state = const <SelectedPhoto>[];
  }
}
