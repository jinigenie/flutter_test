import 'dart:async';
import 'mock_data.dart';

class MockApi {
  Future<List<NewsArticle>> fetchNewsArticles({required int page, required int limit}) async {
    
    await Future.delayed(Duration(seconds: 1));

    int startIndex = page * limit;
    int endIndex = startIndex + limit;
    endIndex = endIndex > mockNewsArticles.length ? mockNewsArticles.length : endIndex;

    // startIndex부터 endIndex까지의 뉴스 기사 슬라이스 반환
    return mockNewsArticles.sublist(startIndex, endIndex);
  }
}