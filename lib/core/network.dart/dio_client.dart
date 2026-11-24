import 'package:dio/dio.dart';

class DioClient {
  static Dio create({required String baseUrl}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Later: dio.interceptors.add(AuthInterceptor(...)) to attach the JWT.
    return dio;
  }
}