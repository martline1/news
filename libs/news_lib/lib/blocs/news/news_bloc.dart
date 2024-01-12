import 'package:bloc/bloc.dart';
import 'package:news_lib/models/article_model.dart';
import 'package:news_lib/models/news_response_model.dart';
import 'package:news_lib/services/news_service.dart';

import 'news_events.dart';
import 'news_state.dart';
import '../../utils/utils.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc()
      : super(const NewsState(
          loading: false,
          apiKey: '',
          articles: [],
          favorites: [],
        )) {
    defineSetters();
    defineMethods();
  }

  defineSetters() {
    on<SetLoading>((event, emit) {
      emit(state.copyWith(loading: event.value));
    });
    on<SetApiKey>(
      transformer: debounce(const Duration(milliseconds: 300)),
      (event, emit) {
        emit(state.copyWith(apiKey: event.value));
      },
    );
    on<SetArticles>((event, emit) {
      emit(state.copyWith(articles: event.value));
    });
    on<AddFavoriteArticle>((event, emit) {
      emit(state.copyWith(favorites: List<ArticleModel>.from([event.value])));
    });
  }

  defineMethods() {
    on<NewsRouteRendered>((event, emit) async {
      add(SetLoading(true));

      final NewsResponseModel? newsResponse =
          await NewsService.getNews(state.apiKey);

      if (newsResponse != null) {
        add(SetArticles(newsResponse.articles));
      }

      add(SetLoading(false));
    });
    on<RemoveFromFavorites>((event, emit) {
      List<ArticleModel> newFavorites =
          List<ArticleModel>.empty(growable: true);

      for (ArticleModel article in state.favorites) {
        if (article.id != event.id) {
          newFavorites.add(article);
        }
      }

      emit(state.changeFavorites(newFavorites));
    });
  }
}
