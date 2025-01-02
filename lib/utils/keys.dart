import 'package:flutter/material.dart';

class GlobalVariableKeys {
  static String? currentRouteName;
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerState =
      GlobalKey<ScaffoldMessengerState>();
}
