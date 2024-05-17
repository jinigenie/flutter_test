import 'package:dio/dio.dart';
import 'package:v3_hyeonjin/model/newsArticle.dart';

class NewsService {
  final String url = 'http://43.202.4.236:8000/news/';
  final Dio _dio = Dio();

  Future<List<NewsArticle>> fetchNewsArticles({required int page, required int limit}) async {
    int startIndex = page * limit;
    int endIndex = startIndex + limit;

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> news_data = response.data;

        endIndex = endIndex > news_data.length ? news_data.length : endIndex;
        List<dynamic> slicedNews = news_data.sublist(startIndex, endIndex);
        
        return slicedNews.map((item) => NewsArticle.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
    
  }

}
