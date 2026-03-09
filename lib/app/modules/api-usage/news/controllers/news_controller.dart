import 'package:api_usage/app/data/models/news_model.dart';
import 'package:api_usage/app/data/repositories/news_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  final NewsRepository repository;

  NewsController({required this.repository});
  final _newsList = <Result>[].obs;
  final _isLoading = false.obs;
  final _isLoadingMore = false.obs;
  final _hasError = false.obs;
  final _errorMessage = ''.obs;
  final _currentPage = 1.obs;
  final _selectedCategory = 'technology'.obs;
  final _hasMoreData = true.obs;

  final searchController = TextEditingController();
  final _isSearching = false.obs;

  List<Result> get newsList => _newsList;
  bool get isLoading => _isLoading.value;
  bool get isLoadingMore => _isLoadingMore.value;
  bool get hasError => _hasError.value;
  String get errorMessage => _errorMessage.value;
  int get currentPage => _currentPage.value;
  String get selectedCategory => _selectedCategory.value;
  bool get hasMoreData => _hasMoreData.value;
  bool get isSearching => _isSearching.value;
  final categories = [
    'technology',
    'business',
    'sports',
    'health',
    'science',
    'entertainment',
    'politics',
    'environment',
  ];

  @override 
  void onInit(){
    super.onInit();
    fetchNews();
  }
  @override
  void onClose(){
    searchController.dispose();
    super.onClose();
  }
  
  Future<void> fetchNews({bool refresh = false})async {
    if (refresh){
      _currentPage.value = 1;
      _newsList.clear();
      _hasMoreData.value = true;
    }
    if (_isLoading.value || _isLoadingMore.value || !_hasMoreData.value) return;
    if (_currentPage.value == 1){
      _isLoading.value = true;
    } else {
      _isLoadingMore.value = true;
    }
    _hasError.value = false;
    try{
      print('📰 Fetching news - Page: ${_currentPage.value}, Category: ${_selectedCategory.value}');
      final news = await repository.getArticles(
        keyword: _selectedCategory.value,
        page: _currentPage.value,
      );
      print('✅ Fetched ${news.length} articles');

      // Check if we got empty results
      if (news.isEmpty) {
        _hasMoreData.value = false;
        if (_currentPage.value == 1) {
          Get.snackbar(
            'No Results',
            'No news articles found',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );
        }
      } else {
        // Add results
        if (refresh) {
          _newsList.assignAll(news);
        } else {
          _newsList.addAll(news);
        }
        _currentPage.value++;
      }
    }catch(e){
      print(  '❌ Error fetching news: $e');
      _hasError.value = true;
      _errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to load news ${_errorMessage.value}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      _isLoading.value = false;
      _isLoadingMore.value = false;
    }
  } 
  Future<void> searchNews(String query) async {
    if (query.trim().isEmpty) {
      _isSearching.value = false;
      fetchNews(refresh: true);
      return;
    }

    print('🔍 Searching: $query');

    _isSearching.value = true;
    _isLoading.value = true;
    _hasError.value = false;
    _newsList.clear();
    _currentPage.value = 1;

    try {
      final news = await repository.searchArticles(
        query: query.trim(),
      );

      print('✅ Found ${news.length} articles');

      _newsList.assignAll(news);

      if (news.isEmpty) {
        Get.snackbar(
          'No Results',
          'No articles found for "$query"',
          snackPosition: SnackPosition.BOTTOM, 
        );
      }
    } catch (e) {
      print('❌ Search error: $e');
      _hasError.value = true;
      _errorMessage.value = e.toString();
      
      Get.snackbar(
        'Error',
        'Failed to search articles',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  /// Change category
  void changeCategory(String category) {
    if (_selectedCategory.value == category) return;

    print('📂 Changing category to: $category');

    _selectedCategory.value = category;
    _isSearching.value = false;
    searchController.clear();
    fetchNews(refresh: true);
  }

  /// Load more articles (pagination)
  void loadMore() {
    if (!_isLoading.value && !_isLoadingMore.value && _hasMoreData.value && !_isSearching.value) {
      print('📄 Loading more articles...');
      fetchNews();
    }
  }

  /// Refresh articles
  @override
  Future<void> refresh() async {
    print('🔄 Refreshing...');
    _isSearching.value = false;
    searchController.clear();
    await fetchNews(refresh: true);
  }

  /// Clear search
  void clearSearch() {
    print('🗑️ Clearing search');
    _isSearching.value = false;
    searchController.clear();
    fetchNews(refresh: true);
  }

  /// Show article stats (for debugging)
  void showStats() {
    Get.snackbar(
      'Stats',
      'Total Articles: ${_newsList.length}\nPage: ${_currentPage.value}\nCategory: $_selectedCategory',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}