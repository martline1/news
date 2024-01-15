import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_lib/blocs/news/news_bloc.dart';
import 'package:news_lib/blocs/news/news_events.dart';
import 'package:news_lib/blocs/news/news_state.dart';
import 'package:news_lib/models/article_model.dart';
import 'package:news_lib/widgets/articles_list.dart';
import 'package:news_lib/widgets/screen_message.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<NewsBloc>().add(GetFavoritesFromDB());
    context.read<NewsBloc>().add(NewsRouteRendered());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.articles.isNotEmpty) {
            final Set<String> favoriteIds = Set<String>.from({});

            for (ArticleModel article in state.favorites) {
              favoriteIds.add(article.id);
            }

            return ArticlesList(
              articles: state.articles,
              favoritesIds: favoriteIds,
            );
          }

          return ScreenMessage(
            label: 'News will appear once you add a valid api key!',
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
