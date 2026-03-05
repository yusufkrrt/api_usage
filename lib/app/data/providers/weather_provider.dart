//==============================================================================
// Burada Dio Kullanıyoruz . GetConnect değil.  ================================
//==============================================================================
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../services/network_service.dart';

class WeatherProvider {
  // Get.find ile önceden oluşturduğumuz NetworkService'e ulaşıyoruz
  final Dio _dio = Get.find<NetworkService>().dio;

  static const String _apiKey = 'fc61d1a68498437ebdf105227260503';

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