import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_provider.g.dart';

@riverpod
class HomeNotifier extends _$HomeNotifier {
  @override
  int build() => 0;

  void increment() => state++;
  void decrement() => state--;
}
