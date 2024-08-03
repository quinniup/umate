import 'package:catcher_2/catcher_2.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umate/components/share/page_route.dart';
import 'package:umate/pages/home/home.dart';
import 'package:umate/pages/pulsar/pulsar.dart';
import 'package:umate/pages/root/root.dart';
import 'package:umate/pages/totp/authenticator.dart';
import 'package:umate/welcome.dart';

final rootNavigatorKey = Catcher2.navigatorKey;
final shellRouteNavigatorKey = GlobalKey<NavigatorState>();
final routerProvider = Provider((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: shellRouteNavigatorKey,
        builder: (context, state, child) => RootApp(child: child),
        routes: [
          GoRoute(
              path: "/",
              name: WelcomePage.name,
              pageBuilder: (context, state) =>
                  const UmatePage(child: WelcomePage()),
              routes: [
                GoRoute(
                  path: "home",
                  name: HomePage.name,
                  pageBuilder: (context, state) =>
                      const UmatePage(child: HomePage()),
                ),
                GoRoute(
                  path: "pulsar",
                  name: PulsarPage.name,
                  pageBuilder: (context, state) =>
                      const UmatePage(child: PulsarPage()),
                ),
                GoRoute(
                  path: "totp",
                  name: TOTPPage.name,
                  pageBuilder: (context, state) =>
                      const UmatePage(child: TOTPPage()),
                )
              ]),
        ],
      ),
    ],
  );
});
