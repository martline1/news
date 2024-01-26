import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:news_lib/blocs/news/news_bloc.dart';
import 'package:news_lib/blocs/news/news_events.dart';
import 'package:news_lib/blocs/news/news_state.dart';
import 'package:news_lib/models/article_model.dart';
import 'package:news_lib/models/source_model.dart';

import '../mocks/mocks.dart';

void main() {
  late MockNewsService service;
  late ArticleModel article;

  const NewsState state = NewsState(
    loading: false,
    apiKey: '683357b0813844ad8df12f3bede6159f',
    loadArticles: true,
    articles: [],
    favorites: [],
  );

  group("NewsBloc", () {
    setUpAll(() {
      article = const ArticleModel(
        id: 'id_1',
        source: SourceModel(name: 'name'),
        author: "author",
        title: "title",
        description: "description",
        url: "url",
        urlToImage: "urlToImage",
        content: "content",
      );
      service = MockNewsService(article);
    });

    test("Initial values are correct", () {
      expect(NewsBloc.initialState, state);
    });

    blocTest(
      'Get Articles works correctly',
      build: () => NewsBloc(newsService: service),
      act: (bloc) => bloc.add(GetArticles()),
      expect: () {
        final change1 = state.copyWith(loadArticles: false);
        final change2 = change1.copyWith(loading: true);
        final change3 = change2.copyWith(articles: [article]);
        final change4 = change3.copyWith(loading: false);

        return [change1, change2, change3, change4];
      },
    );

    blocTest(
      "Add to favorites",
      build: () => NewsBloc(newsService: service),
      act: (bloc) => bloc.add(AddFavoriteArticle(article)),
      expect: () => [
        state.copyWith(favorites: [article])
      ],
    );

    blocTest(
      "Remove from favorites",
      build: () => NewsBloc(newsService: service),
      seed: () => state.copyWith(favorites: [article]),
      act: (bloc) => bloc.add(RemoveFromFavorites(article.id)),
      expect: () => [state.copyWith(favorites: [])],
    );
  });
}
