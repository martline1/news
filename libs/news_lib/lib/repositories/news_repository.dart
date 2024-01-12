import 'package:dio/dio.dart';

class NewsRepository {
  static const String _baseUrl = 'https://newsapi.org/v2/everything';

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
    ),
  );

  static Future<Response> getNews(String apiKey) =>
      _dio.get(Uri(queryParameters: {
        'q': 'flutter',
        'sortBy': 'publishedAt',
        'apiKey': apiKey,
      }).toString());
}
