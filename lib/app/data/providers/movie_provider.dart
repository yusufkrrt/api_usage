import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../services/network_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MovieProvider {
  final Dio _dio = Get.find<NetworkService>().dio;

  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static final String _apiKey = dotenv.env['MOVIE_API_KEY'] ?? '';
  Future<List<dynamic>> getPopularMovies() async {
    try {
      final response = await _dio.get(
        '$_baseUrl/movie/popular',
        queryParameters: {
          'api_key': _apiKey,
          'language': 'tr-TR', // Türkçe destekler
          'page': 1,
        },
      );

      if (response.statusCode == 200) {
        return response.data['results']; // Film listesini döner
      }
      return [];
    } catch (e) {
      print('TMDB Error: $e');
      return [];
    }
  }
}