import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  static final Dio _dio = Dio();

  static void configureDio() {
    _dio.options.baseUrl = dotenv.env['BASE_URL'] ?? '';
  }

  static Future get(String path, {Map<String, dynamic>? headers}) async {
    try {
      final resp = await _dio.get(
        path,
        options: Options(
          headers: headers,
        ),
      );
      return resp;
    } on DioException catch (e) {
      throw ('Error en el GET $e');
    }
  }

  static Future<Response> post(String path, Map<String, dynamic> data,
      {Map<String, dynamic>? headers}) async {
    try {
      final resp = await _dio.post(
        path,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
      return resp;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      } else {
        return Response(
          requestOptions: e.requestOptions,
          statusCode: 500,
          data: {'message': e.message},
        );
      }
    }
  }

  static Future put(String path, Map<String, dynamic> data) async {
    try {
      final resp = await _dio.put(path, data: data);
      return resp;
    } on DioException catch (e) {
      throw ('Error en el PUT $e');
    }
  }

  static Future<Response> delete(String path, Map<String, dynamic> data,
      {Map<String, dynamic>? headers}) async {
    try {
      final resp = await _dio.delete(path,
          data: data,
          options: Options(
            headers: headers,
          ));
      return resp;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      } else {
        return Response(
          requestOptions: e.requestOptions,
          statusCode: 500,
          data: {'message': e.message},
        );
      }
    }
  }
}
