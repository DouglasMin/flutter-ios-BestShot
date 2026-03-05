import 'package:bestshot/core/errors/app_exception.dart';
import 'package:bestshot/features/home/domain/home_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) => HomeRepository();

class HomeRepository {
  /// Fetch items. Replace with actual API call.
  Future<List<HomeModel>> fetchItems() async {
    try {
      // TODO: inject Dio and call real endpoint
      return [
        const HomeModel(id: '1', title: 'Hello', subtitle: 'World'),
      ];
    } catch (e) {
      throw DataException('Failed to fetch items: $e');
    }
  }
}
