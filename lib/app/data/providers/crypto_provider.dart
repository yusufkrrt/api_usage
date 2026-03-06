import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../services/network_service.dart';

class CryptoProvider {
  final Dio _dio = Get.find<NetworkService>().dio;

  // Sandbox veya Pro URL'sini buraya tanımlayın
  static const String _cmcUrl = 'https://sandbox-api.coinmarketcap.com/v1/cryptocurrency/listings/latest';
  static final String _apiKey = dotenv.env['CMC_API_KEY'] ?? '';

  Future<Response> getCryptos() async {
    try {
      // Tam URL'yi buraya veriyoruz, NetworkService'deki baseUrl ezilir
      final response = await _dio.get(
        _cmcUrl,
        queryParameters: {
          'start': '1',
          'limit': '10',
          'convert': 'USD',
        },
        options: Options(
          headers: {
            'X-CMC_PRO_API_KEY': _apiKey, // Sandbox'ta da bu header kullanılır
            'Accept': 'application/json',
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }
}