import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rootscards/config/app.dart';
import 'package:rootscards/helper/helper_function.dart';

class AuthRepository {
  Future<Map<String, dynamic>> login(String email, String password) async {
    String deviceId = await HelperFunction.getDeviceIDfromSF() ?? "N/A";
    final url = Uri.parse("$baseUrl/");
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    final headers = {
      'deviceid': deviceId,
      'Content-Type': 'application/json',
    };

    try {
      final response = await http
          .post(url, body: body, headers: headers)
          .timeout(const Duration(seconds: 30));
      final responseData = jsonDecode(response.body);

      if (responseData['status'] == '200' || responseData['status'] == '201') {
        if (responseData['status'] == '201') {
          await _handleNewUser(responseData['data'], email);
        } else {
          await _processUserData(responseData['details']);
        }
        return responseData;
      } else if (responseData['status'] == '401') {
        debugPrint("$responseData");
        throw 'Incorrect credentials';
      } else {
        throw 'Login failed: ${responseData['data']['message'] ?? 'Something went wrong'}';
      }
    } catch (e) {
      throw 'Something went wrong: $e';
    }
  }

  Future<void> _handleNewUser(Map<String, dynamic> data, String email) async {
    String xpub1 = data['xpub1'];
    String xpub2 = data['xpub2'];
    await HelperFunction.saveUserEmailSF(email);
    await HelperFunction.saveXpub1SF(xpub1);
    await HelperFunction.saveXpub2SF(xpub2);
    debugPrint(email);
    debugPrint("$data");
  }

  Future<void> _processUserData(Map<String, dynamic> userDetails) async {
    await HelperFunction.saveUserEmailSF(userDetails['email']);
    await HelperFunction.saveSpaceNameSF(userDetails['brand']);
    debugPrint("$userDetails");
     debugPrint("$userDetails");

    if (userDetails['banners'] != null) {
      await _saveBanners(userDetails['banners']);
    }
  }

  Future<void> _saveBanners(List<dynamic> banners) async {
    // Implement banner saving logic here
    // This could involve saving to SharedPreferences or another storage method
  }

  ////AUTHENTICATE DEVICE/////

  Future<Map<String, dynamic>> authenticateDevice(String otp) async {
    final url = Uri.parse("$baseUrl/user/authorizeDevice");
    final xpubs = await getStoredXpubs();

    if (xpubs['xpub1'] == null || xpubs['xpub2'] == null) {
      throw Exception('xpub1 or xpub2 not found');
    }

    final body = jsonEncode({
      "deviceId": await HelperFunction.getDeviceIDfromSF(),
      "entry": await HelperFunction.getDeviceEntryFromSF(),
      "deviceName": await HelperFunction.getDeviceNameFromSF(),
      "deviceType": await HelperFunction.getDeviceTypeFromSF(),
      "deviceModel": await HelperFunction.getDeviceModelFromSF(),
      "code": otp,
    });

    final headers = {
      HttpHeaders.authorizationHeader:
          'Basic ${base64Encode(utf8.encode("${xpubs['xpub1']}:${xpubs['xpub2']}"))}',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      final response = await http.post(url, body: body, headers: headers);
      final responseData = jsonDecode(response.body);
      debugPrint("$responseData");
      if (responseData['status'] == '200') {
        await HelperFunction.saveAuthIDSF(responseData['data']['authid']);
        debugPrint(
            ' ${await HelperFunction.saveAuthIDSF(responseData['data']['authid'])}');
        await HelperFunction.saveUserLoggedInStatus(true);
        return responseData;
      }
      if (responseData['status'] == 401) {
        throw ('Correct code required');
      } else {
        throw ("Correct code required.");
      }
    } catch (e) {
      final errorMessage = (e is String) ? e : "Something went wrong";
      debugPrint("Error in authenticateDevice: $errorMessage");
      throw errorMessage;
    }
  }

  ////RESET PASSWORD////

  Future<bool> resetPassword(String email) async {
    final url = Uri.parse('$baseUrl/user/forgotPassword');
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('x-api:$email'))}';

    try {
      final response = await http
          .post(
            url,
            headers: <String, String>{
              'Authorization': basicAuth,
              'Content-Type': 'application/json',
            },
            body: jsonEncode(<String, String>{
              'email': email,
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        String status = responseData['status'];

        if (status == "200") {
          print(responseData);
          return true; // Success
        } else {
          print(responseData);
          // Log the message or handle accordingly
          return false; // Email is incorrect or some other error
        }
      } else {
        // Handle non-200 responses
        return false;
      }
    } catch (e) {
      return false;
    }
  }



}

Future<Map<String, String?>> getStoredXpubs() async {
  String? xpub1 = await HelperFunction.getXpub1fromSF();
  String? xpub2 = await HelperFunction.getXpub2fromSF();

  return {
    'xpub1': xpub1,
    'xpub2': xpub2,
  };
}
