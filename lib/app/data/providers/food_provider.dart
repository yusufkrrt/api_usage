import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FoodProvider {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.spoonacular.com/recipes',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
  static final String _apiKey = dotenv.env['SPOONACULAR_API_KEY'] ?? '';

  Future<Response> searchRecipes(String query) async {
    // ✅ Tüm response döndür, parse işlemi repository'de yapılır
    return await _dio.get(
      '/complexSearch',
      queryParameters: {
        'apiKey': _apiKey,
        'query': query,
        'number': 10,
        'addRecipeInformation': true,
      },
    );
  }
}