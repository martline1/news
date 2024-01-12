import 'package:flutter/material.dart';

import 'package:news_lib/models/article_model.dart';
import 'package:news_lib/widgets/articles_list_card_content.dart';

class ArticlesList extends StatelessWidget {
  final List<ArticleModel> articles;
  final Set<String> favoritesIds;

  const ArticlesList({
    super.key,
    required this.articles,
    required this.favoritesIds,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final viewHeight60Percent = size.height * 0.55;

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final ArticleModel article = articles[index];

        return ListTile(
          title: Card(
            elevation: 8, // the size of the shadow
            shadowColor: Colors.black, // shadow color
            color: Colors.white,
            child: SizedBox(
              width: 320,
              height: viewHeight60Percent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ArticlesListCardContent(
                  article: article,
                  isFavorite: favoritesIds.contains(article.id),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
