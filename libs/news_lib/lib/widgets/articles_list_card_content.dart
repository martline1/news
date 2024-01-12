import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_lib/blocs/news/news_bloc.dart';
import 'package:news_lib/blocs/news/news_events.dart';

import 'package:news_lib/models/article_model.dart';

class ArticlesListCardContent extends StatelessWidget {
  final ArticleModel article;
  final bool isFavorite;

  const ArticlesListCardContent({
    super.key,
    required this.article,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 22.0),
        Row(
          children: [
            Expanded(
              child: Text(
                article.title,
                textAlign: TextAlign.justify,
                softWrap: true,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (isFavorite) {
                  context.read<NewsBloc>().add(RemoveFromFavorites(article.id));
                } else {
                  context.read<NewsBloc>().add(AddFavoriteArticle(article));
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_outline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          article.description,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child: Image.network(
                article.urlToImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
