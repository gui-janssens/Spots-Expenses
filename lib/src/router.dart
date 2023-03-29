import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'interface/utility/utility.dart';
import 'interface/views/views.dart';

final goRouter = GoRouter(
  initialLocation: SplashView.route,
  navigatorKey: InterfaceUtility.instance.navigationKey,
  observers: [
    BotToastNavigatorObserver(),
  ],
  routes: [
    GoRoute(
      name: SplashView.route,
      path: SplashView.route,
      builder: (context, state) => SplashView(),
    ),
  ],
);
