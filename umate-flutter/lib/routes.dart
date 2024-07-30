import 'package:catcher_2/catcher_2.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../pages/home/home.dart';
import '../pages/pulsar/pulsar.dart';
import 'components/share/page_route.dart';
import 'welcome.dart';

final rootNavigatorKey = Catcher2.navigatorKey;
final shellRouteNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
          path: "/",
          name: WelcomePage.name,
          pageBuilder: (context, state) => const UmatePage(child: HomePage()),
          routes: [
            GoRoute(
              path: "pulsar",
              name: PulsarPage.name,
              pageBuilder: (context, state) =>
                  const UmatePage(child: PulsarPage()),
            )
          ]),
    ],
  );
});
