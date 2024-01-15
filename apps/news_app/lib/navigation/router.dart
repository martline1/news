import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:news_lib/screens/screens.dart';
import 'package:news_lib/layouts/layouts.dart';
import 'routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

const _appRoutes = {
  0: Routes.appNews,
  1: Routes.appFavorites,
  2: Routes.appSettings
};

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.splash,
  onException: (context, state, router) => Routes.appNews,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(
        redirectTo: Routes.appNews,
      ),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => appLayoutBuilder(
        _appRoutes,
        context,
        state,
        child,
      ),
      routes: <RouteBase>[
        GoRoute(
          path: Routes.appNews,
          builder: (context, state) => const NewsScreen(),
        ),
        GoRoute(
          path: Routes.appFavorites,
          builder: (context, state) => const FavoritesScreen(),
        ),
        GoRoute(
          path: Routes.appSettings,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);
