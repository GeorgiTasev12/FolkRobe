import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  Future<T?> push<T extends Object?>(Route<T> route) async {
    return await navigatorKey.currentState?.push(route);
  }

  Future<T?> pushReplacement<T extends Object?>(Route<T> route) async {
    return await navigatorKey.currentState?.pushReplacement(route);
  }

  void pop<T extends Object?>([T? result]) {
    return navigatorKey.currentState?.pop(result);
  }
}