import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../services/network_service.dart';

class MusicProvider {
  final Dio _dio = Get.find<NetworkService>().dio;

  static const String _baseUrl='https://itunes.apple.com/search';
  Future <Response> searchMusic(String term)async{
    return await _dio.get(
      '$_baseUrl',
      queryParameters: {
        'term': term,
        'entity': 'song',
      }
    );
  }

  Future<Response> getMusicDetails(String id) async {
    return await _dio.get(
      'https://itunes.apple.com/lookup',
      queryParameters: {
        'id': id,
      }
    );
  }

}

