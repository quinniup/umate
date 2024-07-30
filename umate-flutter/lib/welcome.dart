import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WelcomePage extends HookConsumerWidget {
  const WelcomePage({super.key});
  static const name = 'WelcomePage';

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Welcome to Umate'),
            Text('Please sign in'),
          ],
        ),
      ),
    );
  }
}
