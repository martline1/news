import 'package:dio/dio.dart';

import 'package:news_lib/models/news_response_model.dart';
import 'package:news_lib/repositories/news_repository.dart';

class NewsService {
  static Future<NewsResponseModel?> getNews(String apiKey) async {
    try {
      final Response response = await NewsRepository.getNews(apiKey);

      return NewsResponseModel.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }
}
