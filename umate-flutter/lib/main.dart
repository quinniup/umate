import 'package:catcher_2/catcher_2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'collections/intents.dart';
import 'routes.dart';

void main() {
  Catcher2(
    enableLogger: true,
    runAppFunction: () {
      runApp(
        const ProviderScope(child: UMateAPP()),
      );
    },
  );
}

class UMateAPP extends HookConsumerWidget {
  const UMateAPP({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
        //debugShowCheckedModeBanner: false,
        title: 'UMate',
        theme: ThemeData(
          //colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFA09A9A)),
          useMaterial3: true,
        ),
        routerConfig: router,
        actions: {
          ...WidgetsApp.defaultActions,
          NavigationIntent: NavigationAction(),
          HomeTabIntent: HomeTabAction(),
        });
  }
}
