import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_layout.dart';

Widget appLayoutBuilder(
  Map<int, String> routes,
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  int currentIndex = 0;

  String path = state.fullPath ?? '';

  for (MapEntry<int, String> entry in routes.entries) {
    if (entry.value.contains(path)) {
      currentIndex = entry.key;
      break;
    }
  }

  return AppLayout(
    routes: routes,
    currentIndex: currentIndex,
    child: child,
  );
}
