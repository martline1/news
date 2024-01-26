import 'package:news_lib/models/article_model.dart';
import 'package:equatable/equatable.dart';

class NewsState extends Equatable {
  final bool loading;
  final String apiKey;
  final bool loadArticles;
  final List<ArticleModel> articles;
  final List<ArticleModel> favorites;

  const NewsState({
    required this.loading,
    required this.apiKey,
    required this.loadArticles,
    required this.articles,
    required this.favorites,
  });

  @override
  List<Object> get props => [
        loading,
        apiKey,
        articles,
        loadArticles,
        favorites,
      ];

  void addNewOnes(
    List<ArticleModel> accumulator,
    Set<String> knownIds,
    List<ArticleModel> values,
  ) {
    for (ArticleModel element in values) {
      if (knownIds.contains(element.id)) continue;

      knownIds.add(element.id);
      accumulator.add(element);
    }
  }

  NewsState copyWith({
    bool? loading,
    String? apiKey,
    bool? loadArticles,
    List<ArticleModel>? articles,
    List<ArticleModel>? favorites,
  }) {
    final knownIds = <String>{};
    final mergedArticles = List<ArticleModel>.empty(growable: true);

    final knownFavoriteIds = <String>{};
    final mergedFavoriteArticles = List<ArticleModel>.empty(growable: true);

    addNewOnes(mergedArticles, knownIds, this.articles);
    addNewOnes(mergedArticles, knownIds, articles ?? []);

    addNewOnes(mergedFavoriteArticles, knownFavoriteIds, this.favorites);
    addNewOnes(mergedFavoriteArticles, knownFavoriteIds, favorites ?? []);

    return NewsState(
      loading: loading ?? this.loading,
      apiKey: apiKey ?? this.apiKey,
      loadArticles: loadArticles ?? this.loadArticles,
      articles: mergedArticles,
      favorites: mergedFavoriteArticles,
    );
  }

  NewsState changeFavorites(List<ArticleModel> favorites) {
    return NewsState(
      loading: loading,
      apiKey: apiKey,
      loadArticles: loadArticles,
      articles: articles,
      favorites: favorites,
    );
  }
}
