import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umate/utils/service_utils.dart';

class HomePage extends HookConsumerWidget {
  static const name = "home";
  const HomePage({super.key});
  static final navigatationMap = {
    0: "/",
    1: "/bookmark",
    2: "/pulsar",
  };
  @override
  Widget build(BuildContext context, ref) {
    final controller = useScrollController();

    const selectedIndex = 0;
    final destinations = const [
      NavigationRailDestination(
        icon: Icon(Icons.favorite_border),
        selectedIcon: Icon(Icons.favorite),
        label: Text('Pulsar'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.bookmark_border),
        selectedIcon: Icon(Icons.bookmark),
        label: Text('Bookmark'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.star_border),
        selectedIcon: Icon(Icons.star),
        label: Text('Star'),
      ),
    ];

    return SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: null,
          body: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  NavigationRail(
                      selectedIndex: selectedIndex,
                      onDestinationSelected: (value) {
                        navigate(context, value);
                        print(value);
                      },
                      destinations: destinations),
                  const VerticalDivider(thickness: 1, width: 1),
                  Expanded(
                    child: CustomScrollView(
                      controller: controller,
                      slivers: [
                        const HomeFeaturedSection(),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }

  static void navigate(BuildContext context, int selectIndex) {
    final path = navigatationMap[selectIndex];
    print(path);
    if (path != null) {
      return;
    }
    ServiceUtils.push(context, path!);
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
