import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum SecureStorageData{
  JWT_TOKEN
}

class CustomSecureStorage {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> saveJWTToken(String token) async{
    await secureStorage.write(key: SecureStorageData.JWT_TOKEN.name, value: token);
  }

  Future<String?> getJWTToken() async{
    return secureStorage.read(key: SecureStorageData.JWT_TOKEN.name);
  }

  Future<void> deleteJWTToken() async{
    await secureStorage.delete(key: SecureStorageData.JWT_TOKEN.name);
  }

}