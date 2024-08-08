import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:routetracking/core/networking/api_constant.dart';
import 'package:routetracking/core/networking/api_service.dart';

class DioConsumer extends ApiService {
  final Dio dio;
  DioConsumer({required this.dio}) {
   // dio.options.baseUrl = ApiConstants.apibaseurl;
    dio.interceptors.add(PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }
  @override
  Future get(String path,
      {Object? data,
      Map<String, dynamic>? queryparams,
      Options? obtion}) async {
    try {
      final response = await dio.get(path,
          queryParameters: queryparams, data: data, options: obtion);
      return response.data;
    } on DioException catch (e) {
      print("-- ${e.error}");
    }
    throw UnimplementedError();
  }

  @override
  Future post(String path,
      {data,
      Map<String, dynamic>? queryparams,
      bool isformDta = false,
      Options? options}) async {
    try {
      final response = await dio.post(path,
          data: data, options: options, queryParameters: queryparams);
      return response.data;
    } on DioException catch (e) {
      print("--- $e");
    }

    // TODO: implement post
    throw UnimplementedError();
  }
}
