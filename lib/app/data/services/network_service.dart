// lib/app/data/services/network_service.dart

import 'package:dio/dio.dart';

class NetworkService {
  late Dio _dio;

  NetworkService() {
    _dio = Dio(BaseOptions(
      baseUrl: '',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ));

    _dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));
  }

  Dio get dio => _dio;
}