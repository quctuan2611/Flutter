import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsService {
  static const String _apiKey = 'b269a8003664493bbc272d54c9d4d520';
  static const String _url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$_apiKey';

  static Future<List<Article>> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> articlesJson = data['articles'];
        return articlesJson.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Lỗi khi tải tin tức');
      }
    } catch (e) {
      throw Exception('Không thể kết nối API: $e');
    }
  }
}