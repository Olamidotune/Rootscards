import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rootscards/config/app.dart';
import 'package:rootscards/helper/helper_function.dart';

class AuthServices {
  //login
  Future<Map<String, dynamic>> login(String email, String password) async {
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
        await HelperFunction.saveUserEmailSF(email);
        await HelperFunction.saveXpub1SF(xpub1);
        await HelperFunction.saveXpub2SF(xpub2);
        HelperFunction.userLoggedInKey;
        debugPrint(email);
        debugPrint(password);
        debugPrint(xpub1);
        debugPrint(xpub2);
        debugPrint(response.body);

        return {
          'success': true,
          'email': email,
          "xpub1": xpub1,
          "xpub2": xpub2
        };
      } else {
        throw (responseData['data']['message']);
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  //otp
  Future<Map<String, dynamic>> authOtp(String otp) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? xpub1 = await HelperFunction.getXpub1fromSF();
    String? xpub2 = await HelperFunction.getXpub2fromSF();
    String deviceId = "";
    String entry = "";
    String deviceName = "";
    String deviceType = "";
    String deviceModel = "";

    if (xpub1 == null || xpub2 == null) {
      throw Exception("xpub1 and xpub2 are not found");
    }

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.manufacturer;
        entry = "android";
        deviceName = androidInfo.device;
        deviceType = androidInfo.model;
        deviceModel = androidInfo.product;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor!;
        entry = "ios";
        deviceName = iosInfo.name;
        deviceType = iosInfo.model;
        deviceModel = iosInfo.systemName;
      }
    } catch (e) {
      throw Exception('Failed to get device information: $e');
    }

    Map<String, dynamic> requestBody = {
      "deviceId": deviceId,
      "entry": entry,
      "deviceName": deviceName,
      "deviceType": deviceType,
      "deviceModel": deviceModel,
      "code": otp,
    };

    String encodedBody = json.encode(requestBody);

    http.Response response = await http
        .post(
          Uri.parse("$baseUrl/user/authorizeDevice"),
          headers: {
            HttpHeaders.authorizationHeader:
                'Basic ${base64Encode(utf8.encode("$xpub1:$xpub2"))}',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: encodedBody,
        )
        .timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      String status = responseData['status'];

      if (status == "200") {
        String authid = responseData['data']['authid'];
        await HelperFunction.saveAuthIDSF(authid);
        debugPrint(authid);
        debugPrint(response.body);
        return responseData;
      } else {
        throw ("Oops ${responseData['data']['message']}");
      }
    } else {
      throw Exception('Failed to authorize device');
    }
  }
}
