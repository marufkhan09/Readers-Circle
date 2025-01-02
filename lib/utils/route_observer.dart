import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:readers_circle/utils/keys.dart';

class MyRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is PageRoute) {
      GlobalVariableKeys.currentRouteName = route.settings.name;
      log('Route Pushed: ${GlobalVariableKeys.currentRouteName}');
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute is PageRoute) {
      GlobalVariableKeys.currentRouteName = previousRoute.settings.name;
      log('Route Popped: ${GlobalVariableKeys.currentRouteName}');
    }
    super.didPop(route, previousRoute);
  }
}
