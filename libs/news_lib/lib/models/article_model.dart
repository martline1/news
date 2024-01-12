import 'package:equatable/equatable.dart';
import 'package:news_lib/models/source_model.dart';

class ArticleModel extends Equatable {
  final String id;
  final SourceModel source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String content;

  const ArticleModel({
    required this.id,
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
  });

  @override
  List<Object> get props => [
        id,
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        content,
      ];

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json['author'].toString() + json['title'].toString(),
        source: json['source'] != null
            ? SourceModel.fromJson(json['source'])
            : const SourceModel(name: 'Unknown source'),
        author: json['author'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        url: json['url'] ?? '',
        urlToImage: json['urlToImage'] ?? '',
        content: json['content'] ?? '',
      );
}
