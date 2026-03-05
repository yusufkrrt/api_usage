import '../models/news_model.dart';
import '../providers/news_api_provider.dart';

class NewsRepository {
  NewsRepository({required this.apiProvider});

  final NewsApiProvider apiProvider;

  /// Get articles with optional keyword filter
  Future<List<Result>> getArticles({
    String? keyword,
    String lang = 'eng',
    int page = 1,
  }) async {
    try {
      final response = await apiProvider.getArticles(
        keyword: keyword,
        lang: lang,
        page: page,
      );

      if (response.hasError) {
        throw Exception('Failed to load articles: ${response.statusText}');
      }

      if (response.body == null) {
        throw Exception('Empty response body');
      }

      return response.body!.articles.results;
    } catch (e) {
      print('❌ Repository Error (getArticles): $e');
      throw Exception('Error fetching articles: $e');
    }
  }

  /// Search articles by query
  Future<List<Result>> searchArticles({
    required String query,
    String lang = 'eng',
    int page = 1,
  }) async {
    try {
      if (query.trim().isEmpty) {
        throw Exception('Search query cannot be empty');
      }

      final response = await apiProvider.searchArticles(
        query: query,
        lang: lang,
        page: page,
      );

      if (response.hasError) {
        throw Exception('Failed to search articles: ${response.statusText}');
      }

      if (response.body == null) {
        throw Exception('Empty response body');
      }

      return response.body!.articles.results;
    } catch (e) {
      print('❌ Repository Error (searchArticles): $e');
      throw Exception('Error searching articles: $e');
    }
  }

  /// Get articles by category
  Future<List<Result>> getArticlesByCategory({
    required String category,
    String lang = 'eng',
    int page = 1,
  }) async {
    try {
      final response = await apiProvider.getArticlesByCategory(
        category: category,
        lang: lang,
        page: page,
      );

      if (response.hasError) {
        throw Exception('Failed to load category articles: ${response.statusText}');
      }

      if (response.body == null) {
        return [];
      }

      return response.body!.articles.results;
    } catch (e) {
      print('❌ Repository Error (getArticlesByCategory): $e');
      throw Exception('Error fetching category articles: $e');
    }
  }

  /// Get trending articles
  Future<List<Result>> getTrendingArticles({
    String lang = 'eng',
    int page = 1,
  }) async {
    try {
      final response = await apiProvider.getTrendingArticles(
        lang: lang,
        page: page,
      );

      if (response.hasError) {
        throw Exception('Failed to load trending articles: ${response.statusText}');
      }

      if (response.body == null) {
        return [];
      }

      return response.body!.articles.results;
    } catch (e) {
      print('❌ Repository Error (getTrendingArticles): $e');
      throw Exception('Error fetching trending articles: $e');
    }
  }

  /// Get article details by URI
  Future<Result?> getArticleByUri(String uri) async {
    try {
      // This would require a specific endpoint from the API
      // For now, we'll return null as this might not be available
      print('⚠️ getArticleByUri not implemented yet');
      return null;
    } catch (e) {
      print('❌ Repository Error (getArticleByUri): $e');
      return null;
    }
  }

  /// Check API health
  Future<bool> checkApiHealth() async {
    try {
      final response = await apiProvider.getArticles(
        articlesCount: 1,
        page: 1,
      );

      return !response.hasError && response.body != null;
    } catch (e) {
      print('❌ API Health Check Failed: $e');
      return false;
    }
  }
}