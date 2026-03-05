//==============================================================================
// Burada Dio Kullanıyoruz . GetConnect değil.  ================================
//==============================================================================
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;
import '../services/network_service.dart';

class WeatherProvider {
  // Get.find ile önceden oluşturduğumuz NetworkService'e ulaşıyoruz
  final Dio _dio = Get.find<NetworkService>().dio;

  static final String _apiKey = dotenv.env['WEATHER_API_KEY'] ?? '';

  Future<Response> getWeather(String city,int days) async {
    try {
      final response = await _dio.get('/current.json', queryParameters: {
        'key': _apiKey,
        'q': city,
        'days': days,
        'lang': 'tr',
      });
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }
}