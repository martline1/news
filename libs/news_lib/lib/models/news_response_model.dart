import 'package:equatable/equatable.dart';

import 'article_model.dart';

class NewsResponseModel extends Equatable {
  final String status;
  final int totalResults;
  final List<ArticleModel> articles;

  const NewsResponseModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  @override
  List<Object> get props => [
        status,
        totalResults,
        articles,
      ];

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) =>
      NewsResponseModel(
        status: json['status'] ?? '',
        totalResults: json['totalResults'] ?? 0,
        articles: List<ArticleModel>.from((json['articles'] as Iterable).map(
          (e) => ArticleModel.fromJson(e),
        )),
      );
}
