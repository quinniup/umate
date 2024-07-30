import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PulsarPage extends HookConsumerWidget {
  static const name = 'PulsarPage';

  const PulsarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Pulsar'),
      ),
    );
  }
}
