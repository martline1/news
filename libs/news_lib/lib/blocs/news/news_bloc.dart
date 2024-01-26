import 'package:bloc/bloc.dart';
import 'package:news_lib/models/article_model.dart';
import 'package:news_lib/models/news_response_model.dart';
import 'package:news_lib/services/news_service.dart';

import 'news_events.dart';
import 'news_state.dart';
import '../../utils/utils.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsService newsService;

  static const NewsState initialState = NewsState(
    loading: false,
    // Api Key requested by hiring manager to be in code
    // This can also be changed for any api key on the
    // settings screen.
    apiKey: '683357b0813844ad8df12f3bede6159f',
    loadArticles: true,
    articles: [],
    favorites: [],
  );

  NewsBloc({
    required this.newsService,
  }) : super(initialState) {
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
    on<SetLoadArticles>((event, emit) {
      emit(state.copyWith(loadArticles: event.value));
    });
  }

  // Methods define logic that emits a series of events
  // and calls services
  defineMethods() {
    on<AddFavoriteArticle>((event, emit) {
      newsService.addFavorite(event.value);

      emit(state.copyWith(favorites: List<ArticleModel>.from([event.value])));
    });
    on<GetArticles>((event, emit) async {
      if (!state.loadArticles) return;

      add(SetLoadArticles(false));

      // Fetch data only every 30 seconds
      Future.delayed(const Duration(seconds: 30), () {
        add(SetLoadArticles(true));
      });

      add(SetLoading(true));

      final NewsResponseModel? newsResponse =
          await newsService.getNews(state.apiKey);

      if (newsResponse != null) {
        add(SetArticles(newsResponse.articles));
      }

      add(SetLoading(false));
    });
    on<RemoveFromFavorites>((event, emit) {
      final articleToRemove = firstWhereOrNull(
        state.favorites,
        (ArticleModel article) => article.id == event.id,
      );

      if (articleToRemove == null) return;

      newsService.removeFavoriteIfExists(articleToRemove.id);

      emit(state.changeFavorites(
        List<ArticleModel>.from(
          state.favorites.where((article) => article.id != event.id),
        ),
      ));
    });
    on<GetFavoritesFromDB>((event, emit) async {
      final List<ArticleModel> favorites =
          await newsService.getLocalFavorites();

      emit(state.copyWith(favorites: favorites));
    });
  }
}
