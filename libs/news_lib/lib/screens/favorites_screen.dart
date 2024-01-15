import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_lib/blocs/news/news_bloc.dart';
import 'package:news_lib/blocs/news/news_events.dart';
import 'package:news_lib/blocs/news/news_state.dart';
import 'package:news_lib/models/article_model.dart';
import 'package:news_lib/widgets/articles_list.dart';
import 'package:news_lib/widgets/screen_message.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();

    context.read<NewsBloc>().add(GetFavoritesFromDB());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state.articles.isNotEmpty && state.favorites.isNotEmpty) {
            final Set<String> favoriteIds = Set<String>.from({});

            for (ArticleModel article in state.favorites) {
              favoriteIds.add(article.id);
            }

            return ArticlesList(
              articles: state.favorites,
              favoritesIds: favoriteIds,
            );
          }

          return ScreenMessage(
            label: 'News will appear once you add them to favorites!',
            icon: Icons.library_books_outlined,
            labelColor: Colors.grey[600]!,
            iconColor: Colors.grey[600]!,
            fontSize: 16,
          );
        },
      ),
    );
  }
}
