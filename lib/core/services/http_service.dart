import 'package:dio/dio.dart';

abstract class BaseHttpService {
  /// Sends a GET request to the specified [url].
  ///
  /// [endpoint]: The endpoint  to send the GET request.
  /// Returns a response of type [T] on success.
  /// [queryParameters] The query parameters to send in the get request.

  Future<T> get<T>(String url, {Map<String, String>? queryParameters});

  /// Sends a POST request to the specified [url] with the provided [body].
  ///
  /// [url]: The endpoint URL to send the POST request.
  /// [body]: The data to send in the POST request.
  /// [queryParameters] The query parameters to send in the POST request.
  ///
  /// Returns a response of type [T] on success.
  Future<T> post<T>(String url,
      {required dynamic body, Map<String, String>? queryParameters});
}

class DioHttpService implements BaseHttpService {
  final Dio _dio;

  DioHttpService({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                  baseUrl: 'https://dummyjson.com',
                  headers: {'api-key': 'SOME_API_KEY_FROM_ENVIRONMENT'}),
            );

  @override
  Future<T> get<T>(String endpoint, {Map<String, String>? queryParameters}) async {
    try {
      final response = await _dio.get(
        endpoint,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw Exception('Failed to GET data: $e');
    }
  }

  @override
  Future<T> post<T>(String url,
      {required dynamic body, Map<String, String>? queryParameters}) async {
    try {
      final response =
          await _dio.post(url, data: body, queryParameters: queryParameters);
      return response.data as T;
    } on DioException catch (e) {
      throw Exception('Failed to POST data: $e');
    }
  }
}
