import 'package:flutter/material.dart' hide Element;
import 'package:go_router/go_router.dart';

abstract class ServiceUtils {
  // static final logger = Logger('ServiceUtils');

  static void navegate(BuildContext context, String location, {Object? exts}) {
    if (GoRouterState.of(context).matchedLocation == location) return;
    GoRouter.of(context).go(location, extra: exts);
  }

  static void navegateNamed(BuildContext context, String location, Object? exts,
      Map<String, String> pathParams, Map<String, String> queryParams) {
    if (GoRouterState.of(context).matchedLocation == location) return;
    GoRouter.of(context).goNamed(location,
        pathParameters: pathParams, queryParameters: queryParams, extra: exts);
  }

  static void push(BuildContext context, String location, {Object? exts}) {
    final router = GoRouter.of(context);
    final routerState = GoRouterState.of(context);
    final routerLocations = router.routerDelegate.currentConfiguration.matches
        .map((e) => e.matchedLocation);
    if (routerState.matchedLocation == location) return;
    if (routerLocations.contains(location)) return;
    router.push(location, extra: exts);
  }

  static void pushNamed(BuildContext context, String location, Object? exts,
      Map<String, String> pathParams, Map<String, String> queryParams) {
    final router = GoRouter.of(context);
    final routerState = GoRouterState.of(context);
    final routerLocations = router.routerDelegate.currentConfiguration.matches
        .map((e) => e.matchedLocation);

    final locationName = routerState.namedLocation(location,
        pathParameters: pathParams, queryParameters: queryParams);

    if (routerState.matchedLocation == locationName) return;
    if (routerLocations.contains(locationName)) return;
    router.pushNamed(location,
        pathParameters: pathParams, queryParameters: queryParams, extra: exts);
  }
}
