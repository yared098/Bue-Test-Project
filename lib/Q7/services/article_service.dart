import 'dart:convert';
import 'package:buedelivery/Q7/model/article.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ArticleService {
  static const String _apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  static const String _cacheKey = 'cached_articles';

  Future<List<Article>> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        print(data);
        final articles = data.map((json) => Article.fromJson(json)).toList();

        // Save to cache
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(_cacheKey, json.encode(data));

        return List<Article>.from(articles);
      } else {
        throw Exception('error fetching articles');
      }
    } catch (_) {
      // if no internet connection, load from cache
      // Load from cache if available
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_cacheKey);
      if (cachedData != null) {
        List data = json.decode(cachedData);
        print("catched data ${data}");
        return data.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('No internet and no cached data');
      }
    }
  }
}
