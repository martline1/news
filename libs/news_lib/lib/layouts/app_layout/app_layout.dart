import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/news/news_bloc.dart';
export 'app_layout_builder.dart';

class AppLayout extends StatelessWidget {
  final Map<int, String> routes;
  final int currentIndex;
  final Widget child;

  final GetIt getIt = GetIt.instance;

  AppLayout({
    super.key,
    required this.child,
    required this.routes,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (BuildContext context) => NewsBloc(newsService: getIt()),
            ),
          ],
          child: child,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) => context.push(routes[index] ?? routes[0]!),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 0 ? Icons.newspaper : Icons.newspaper_outlined,
            ),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 1
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              currentIndex == 2 ? Icons.settings : Icons.settings_outlined,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}
