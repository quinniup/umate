import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/home/home.dart';
import '../routes.dart';

enum HomeTabs {
  browse,
  search,
  library,
  lyrics,
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
      case HomeTabs.search:
      // TODO: Handle this case.
      case HomeTabs.library:
      // TODO: Handle this case.
      case HomeTabs.lyrics:
      // TODO: Handle this case.
    }
    return null;
  }
}
