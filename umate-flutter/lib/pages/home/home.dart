import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  static const name = "home";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final controller = useScrollController();

    const selectedIndex = 0;

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

class HomeFeaturedSection extends HookConsumerWidget {
  const HomeFeaturedSection({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return const SliverToBoxAdapter(
      child: Column(
        children: [
          const Gap(10),
          const Text("Featured"),
          const Gap(10),
          const Divider(),
          const Gap(10),
          const Text("Featured"),
          const Gap(10),
          const Divider(),
          const Gap(10),
          const Text("Featured"),
          const Gap(10),
          const Divider(),
          const Gap(10),
          const Text("Featured"),
          const Gap(10),
          const Divider(),
          const Gap(10),
          const Text("Featured"),
          const Gap(10),
          const Divider(),
          const Gap(10),
          const Text("Featured"),
          const Gap(10),
          const Divider(),
          const Gap(10),
          const Text("Featured"),
          const Gap(10),
          const Divider(),
          const Gap(10),
          const Text("Featured"),
          const Gap(10),
          const Divider(),
          const Gap(10),
          const Text("Featured"),
          const Gap(10),
          const Divider(),
          const Gap(10),
        ],
      ),
    );
  }
}
