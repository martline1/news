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
          // Api Key requested by hiring manager to be in code
          // This can also be changed for any api key on the
          // settings screen.
          apiKey: '683357b0813844ad8df12f3bede6159f',
          articles: [],
          favorites: [],
        )) {
    defineSetters();
    defineMethods();
  }

  // Setters only emit a state change
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
  }

  // Methods define logic that emits a series of events
  // and calls services
  defineMethods() {
    on<AddFavoriteArticle>((event, emit) {
      NewsService.addFavorite(event.value);

      emit(state.copyWith(favorites: List<ArticleModel>.from([event.value])));
    });
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
      final articleToRemove = firstWhereOrNull(
        state.articles,
        (ArticleModel article) => article.id == event.id,
      );

      if (articleToRemove == null) return;

      NewsService.removeFavoriteIfExists(articleToRemove.id);

      emit(state.changeFavorites(
        List<ArticleModel>.from(
          state.favorites.where((article) => article.id != event.id),
        ),
      ));
    });
    on<GetFavoritesFromDB>((event, emit) async {
      final List<ArticleModel> favorites =
          await NewsService.getLocalFavorites();

      emit(state.copyWith(favorites: favorites));
    });
  }
}
