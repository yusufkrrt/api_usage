import 'package:api_usage/app/data/models/movie_model.dart';
import 'package:api_usage/app/data/providers/movie_provider.dart';

class MovieRepository {
  final MovieProvider apiProvider;

  MovieRepository({required this.apiProvider});

  Future<List<Result>> fetchMovies() async {
    try {
      final List<dynamic> response = await apiProvider.getPopularMovies();
      if (response.isNotEmpty) {
        return response.map((json) => Result.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Repository Popüler Film Hatası: $e");
    }
  }

  Future<List<Result>> searchMovies(String query) async {
    try {
      final List<dynamic> response = await apiProvider.searchMovies(query);
      if (response.isNotEmpty) {
        return response.map((json) => Result.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("Repository Film Arama Hatası: $e");
    }
  }
}
