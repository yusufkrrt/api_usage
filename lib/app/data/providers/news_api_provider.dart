import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '../models/news_model.dart';

class NewsApiProvider extends GetConnect {
  static const String _baseUrl = 'https://eventregistry.org/api/v1';
  static final String _apiKey = dotenv.env['NEWS_API_KEY'] ?? '';
  @override
  void onInit() {
    httpClient.baseUrl = _baseUrl;
    httpClient.timeout = const Duration(seconds: 30);

    // Request interceptor - Log requests
    httpClient.addRequestModifier<void>((request) {
      print('🌐 API Request: ${request.method} ${request.url}');
      return request;
    });

    // Response interceptor - Log responses
    httpClient.addResponseModifier((request, response) {
      print('✅ API Response: ${response.statusCode} - ${response.request?.url}');
      return response;
    });

    super.onInit();
  }

  /// Get articles with filters
  Future<Response<NewsModel>> getArticles({
    String? keyword,
    String lang = 'eng',
    int page = 1,
    int articlesCount = 20,
    String sortBy = 'date', // date, rel, sourceImportance
  }) async {
    final queryParams = {
      'apiKey': _apiKey,
      'lang': lang,
      'articlesPage': page.toString(),
      'articlesCount': articlesCount.toString(),
      'articlesSortBy': sortBy,
      'articlesSortByAsc': 'desc',
      'includeArticleImage': 'true',
      'includeArticleBody': 'true',
      'resultType': 'articles',
    };

    // Add keyword if provided
    if (keyword != null && keyword.isNotEmpty) {
      queryParams['keyword'] = keyword;
    }

    try {
      final response = await get(
        '/article/getArticles',
        query: queryParams,
      );

      if (response.hasError) {
        print('❌ API Error: ${response.statusText}');
        return Response(
          statusCode: response.statusCode,
          statusText: response.statusText ?? 'Unknown error',
        );
      }

      if (response.body == null) {
        print('❌ Empty response body');
        return Response(
          statusCode: 204,
          statusText: 'Empty response',
        );
      }

      return Response(
        statusCode: response.statusCode,
        body: NewsModel.fromJson(response.body),
        statusText: response.statusText,
      );
    } catch (e) {
      print('❌ Exception in getArticles: $e');
      return Response(
        statusCode: 500,
        statusText: 'Exception: $e',
      );
    }
  }

  /// Search articles by query
  Future<Response<NewsModel>> searchArticles({
    required String query,
    String lang = 'eng',
    int page = 1,
    int count = 20,
  }) async {
    return getArticles(
      keyword: query,
      lang: lang,
      page: page,
      articlesCount: count,
      sortBy: 'rel', // Sort by relevance for search
    );
  }

  /// Get articles by category
  Future<Response<NewsModel>> getArticlesByCategory({
    required String category,
    String lang = 'eng',
    int page = 1,
    int count = 20,
  }) async {
    return getArticles(
      keyword: category,
      lang: lang,
      page: page,
      articlesCount: count,
      sortBy: 'date',
    );
  }

  /// Get articles by source
  Future<Response<NewsModel>> getArticlesBySource({
    required String sourceUri,
    String lang = 'eng',
    int page = 1,
    int count = 20,
  }) async {
    final queryParams = {
      'apiKey': _apiKey,
      'sourceUri': sourceUri,
      'lang': lang,
      'articlesPage': page.toString(),
      'articlesCount': count.toString(),
      'articlesSortBy': 'date',
      'resultType': 'articles',
      'includeArticleImage': 'true',
      'includeArticleBody': 'true',
    };

    try {
      final response = await get(
        '/article/getArticles',
        query: queryParams,
      );

      if (response.hasError || response.body == null) {
        return Response(
          statusCode: response.statusCode,
          statusText: response.statusText ?? 'Error fetching articles',
        );
      }

      return Response(
        statusCode: response.statusCode,
        body: NewsModel.fromJson(response.body),
        statusText: response.statusText,
      );
    } catch (e) {
      print('❌ Exception in getArticlesBySource: $e');
      return Response(
        statusCode: 500,
        statusText: 'Exception: $e',
      );
    }
  }

  /// Get trending articles
  Future<Response<NewsModel>> getTrendingArticles({
    String lang = 'eng',
    int page = 1,
    int count = 20,
  }) async {
    return getArticles(
      lang: lang,
      page: page,
      articlesCount: count,
      sortBy: 'sourceImportance',
    );
  }
}