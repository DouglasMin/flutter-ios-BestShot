import 'package:app_name/features/home/presentation/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(homeNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Text(
          '$count',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ref.read(homeNotifierProvider.notifier).increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
