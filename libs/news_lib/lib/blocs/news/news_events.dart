import 'package:news_lib/models/article_model.dart';

abstract class NewsEvent {}

// Setters
class SetLoading extends NewsEvent {
  final bool value;

  SetLoading(this.value);
}

class SetApiKey extends NewsEvent {
  final String value;

  SetApiKey(this.value);
}

class SetArticles extends NewsEvent {
  final List<ArticleModel> value;

  SetArticles(this.value);
}

class AddFavoriteArticle extends NewsEvent {
  final ArticleModel value;

  AddFavoriteArticle(this.value);
}

// Methods
class NewsRouteRendered extends NewsEvent {}

class GetFavoritesFromDB extends NewsEvent {}

class SyncDatabase extends NewsEvent {}

class RemoveFromFavorites extends NewsEvent {
  final String id;

  RemoveFromFavorites(this.id);
}
