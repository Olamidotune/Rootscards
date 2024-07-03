import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rootscards/config/app.dart';
import 'package:rootscards/helper/helper_function.dart';

class AuthServices {
  Future<bool> login(String email, String password) async {
    Map<String, String> requestBody = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse("$baseUrl/"),
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    ).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      String status = responseData['status'];
      if (status == "201") {
        String xpub1 = responseData['data']['xpub1'];
        String xpub2 = responseData['data']['xpub2'];
        await HelperFunction.saveXpub1SF(xpub1);
        await HelperFunction.saveXpub2SF(xpub2);
        await HelperFunction.saveUserEmailSF(email);
        HelperFunction.userLoggedInKey;
        return true;
      } else {
        throw Exception(responseData['data']['message']);
      }
    } else {
      throw Exception('Failed to login');
    }
  }
}
