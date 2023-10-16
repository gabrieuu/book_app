import 'package:book_app/service/client_http/client_http.dart';
import 'package:dio/dio.dart';

class DioClient implements ClientHttp{

  final Dio dio = Dio();

  @override
  Future get(String url) async {
   final response = await dio.get(url);
   return response.data;
  }

}