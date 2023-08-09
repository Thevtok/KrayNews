import 'package:dio/dio.dart';

import '../models/article.dart';

class DataService {
  final Dio _dio = Dio();
  final String apiKey = 'e99aec7e0ea6411ba009e40aad32448e';
  final String baseUrl = 'https://newsapi.org/v2/';

  Future<List<Article>> getAppleArticles() async {
    final String url =
        '$baseUrl/everything?q=apple&from=2023-08-06&to=2023-08-06&sortBy=popularity&apiKey=$apiKey';

    return _getArticles(url);
  }

  Future<List<Article>> getTeslaArticles() async {
    final String url =
        '$baseUrl/everything?q=tesla&from=2023-07-09&sortBy=publishedAt&apiKey=$apiKey';
    return _getArticles(url);
  }

  Future<List<Article>> getBusinessArticles() async {
    final String url =
        '$baseUrl/top-headlines?country=us&category=business&apiKey=$apiKey';
    return _getArticles(url);
  }

  Future<List<Article>> getTechCrunchArticles() async {
    final String url =
        '$baseUrl/top-headlines?sources=techcrunch&apiKey=$apiKey';
    return _getArticles(url);
  }

  Future<List<Article>> getWallStreetArticles() async {
    final String url = '$baseUrl/everything?domains=wsj.com&apiKey=$apiKey';
    return _getArticles(url);
  }

  Future<List<Article>> _getArticles(String url) async {
    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final List<Article> articles = (response.data['articles'] as List)
            .map((data) => Article.fromJson(data))
            .toList();

        return articles;
      } else {
        throw Exception('Terjadi kesalahan saat mengambil artikel.');
      }
    } catch (error) {
      return [];
    }
  }
}
