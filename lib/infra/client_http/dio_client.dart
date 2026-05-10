import 'package:book_app/infra/client_http/client_http.dart';
import 'package:book_app/infra/custom_interceptor.dart';
import 'package:book_app/shared/env_variables.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient implements ClientHttp {
  late final Dio _dio;

  DioClient(){
    _dio = Dio();
    _dio.options.baseUrl = dotenv.env[EnvVariables.API_BASE_URL.name] ?? '';
    _dio.interceptors.add(CustomInterceptor());
  }

  @override
  Future get(String url, {Map<String, dynamic>? params}) async {
    final response = await _dio.get(url, queryParameters: params);
    return response.data;
  }

  Future post(String url, {Map<String, dynamic>? data})async{
    final response = await _dio.post(url, data: data); 
    return response.data;
  }
}
