import 'package:book_app/core/client_http/client_http.dart';
import 'package:dio/dio.dart';

class DioClient implements ClientHttp {
  final Dio dio = Dio();

  @override
  Future get(String url, {Map<String, dynamic>? params}) async {
    final response = await dio.get(url, queryParameters: params);
    return response.data;
  }
}
