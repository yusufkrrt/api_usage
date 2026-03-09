import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/movie_model.dart';
import '../../../data/repositories/movie_repository.dart';

class MovieController extends GetxController with StateMixin<List<Result>> {
  final MovieRepository movieRepository;
  
  MovieController({required this.movieRepository});

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchPopularMovies();
  }

  void fetchPopularMovies() async {
    change(null, status: RxStatus.loading());
    try {
      final movies = await movieRepository.fetchMovies();
      if (movies.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(movies, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error("Filmler yüklenemedi: $e"));
    }
  }

  void searchMovies(String query) async {
    if (query.isEmpty) {
      fetchPopularMovies();
      return;
    }

    change(null, status: RxStatus.loading());
    try {
      final movies = await movieRepository.searchMovies(query);
      if (movies.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(movies, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error("Arama sırasında hata oluştu: $e"));
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
