import 'package:bot_toast/bot_toast.dart';
import 'package:go_router/go_router.dart';

import 'data/providers/providers.dart';
import 'interface/utility/utility.dart';
import 'interface/views/views.dart';

final goRouter = GoRouter(
  initialLocation: SplashView.route,
  navigatorKey: InterfaceUtility.instance.navigationKey,
  redirect: (context, state) async {
    if (state.location == SplashView.route) return null;

    await CompanyProvider.instance.getCompany();

    return null;
  },
  observers: [
    BotToastNavigatorObserver(),
  ],
  routes: [
    GoRoute(
      name: SplashView.route,
      path: SplashView.route,
      builder: (context, state) => SplashView(),
    ),
    GoRoute(
      name: HomeView.route,
      path: HomeView.route,
      builder: (context, state) => HomeView(),
    ),
  ],
);
