import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:umate/pages/pulsar/pulsar.dart';
import 'package:umate/pages/totp/authenticator.dart';

import '../pages/home/home.dart';
import '../routes.dart';

class NavigationIntent extends Intent {
  final GoRouter router;
  final String path;
  const NavigationIntent(this.router, this.path);
}

class NavigationAction extends Action<NavigationIntent> {
  @override
  invoke(intent) {
    intent.router.go(intent.path);
    return null;
  }
}

enum HomeTabs {
  browse,
  totp,
  pulsar,
  etcd,
}

class HomeTabIntent extends Intent {
  final WidgetRef ref;
  final HomeTabs tab;
  const HomeTabIntent(this.ref, {required this.tab});
}

class HomeTabAction extends Action<HomeTabIntent> {
  @override
  invoke(intent) {
    final router = intent.ref.read(routerProvider);
    switch (intent.tab) {
      case HomeTabs.browse:
        router.goNamed(HomePage.name);
        break;
      case HomeTabs.totp:
        router.goNamed(TOTPPage.name);
        break;
      case HomeTabs.pulsar:
        router.goNamed(PulsarPage.name);
      case HomeTabs.etcd:
      // TODO: Handle this case.
    }
    return null;
  }
}
