import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepo {
  static String baseUrl = "https://api.idonland.com";

  var loginUrl = "$baseUrl/";

  final FlutterSecureStorage storage = FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<bool> hasToken() async {
    var value = await storage.read(key: "token");
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> presisteToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  Future<void> deleteToken() async {
    await storage.delete(key: "token");
    storage.deleteAll();
  }

  Future<String> login(String email, String password) async {
    Response response = await _dio.post(loginUrl, data: {
      "email": email,
      "password": password,
    });
    return response.data["data"]["message"];
  }
}
