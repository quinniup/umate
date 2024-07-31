import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TOTPPage extends HookConsumerWidget {
  static const name = 'TOTP';

  const TOTPPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('TOTP'),
      ),
    );
  }
}
