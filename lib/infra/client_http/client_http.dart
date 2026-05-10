abstract class ClientHttp{

  Future<dynamic> get(String url, {Map<String, dynamic>? params});
  Future post(String url, {Map<String, dynamic>? data});
}