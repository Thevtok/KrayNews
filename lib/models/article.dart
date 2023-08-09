import 'package:intl/intl.dart';

class Article {
  final Map<String, dynamic> source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt; // Tipe data DateTime
  final String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: json['source'] ?? {},
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: DateTime.parse(
          json['publishedAt']), // Parsing string menjadi DateTime
      content: json['content'] ?? '',
    );
  }

  String? getSourceName() {
    return source['name'];
  }

  String? getSourceId() {
    return source['id'];
  }

  String getFormattedDate() {
    return DateFormat('MMMM d, y').format(publishedAt);
  }
}
