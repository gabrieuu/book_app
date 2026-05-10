import 'dart:developer';

import 'package:book_app/database/secure_storage/custom_secure_storage.dart';
import 'package:dio/dio.dart';

class CustomInterceptor implements Interceptor {

  final customSecureStorage = CustomSecureStorage();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if(err.response?.statusCode == 401){
      customSecureStorage.deleteJWTToken();
    }

    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    final token = await customSecureStorage.getJWTToken();
    if(token != null){
      options.headers['Authorization'] = 'Bearer $token';
    }

    log('REQUEST[${options.method}] => ${options.path}');

    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
     handler.next(response);
  }
}