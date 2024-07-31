import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umate/pages/home/home.dart';
import 'package:umate/pages/root/sidebar.dart';
import 'package:umate/utils/platform.dart';

class RootApp extends HookConsumerWidget {
  final Widget child;
  const RootApp({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final routerState = GoRouterState.of(context);
        if (routerState.matchedLocation != "/") {
          context.goNamed(HomePage.name);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Sidebar(child: child),
        extendBody: true,
        drawerScrimColor: Colors.transparent,
        endDrawer: kIsDesktop
            ? Container(
                constraints: const BoxConstraints(maxWidth: 800),
                decoration: BoxDecoration(),
                margin: const EdgeInsets.only(
                  top: 40,
                  bottom: 100,
                ),
              )
            : null,
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [],
        ),
      ),
    );
  }
}
