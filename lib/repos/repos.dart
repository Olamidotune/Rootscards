import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rootscards/config/app.dart';
import 'package:rootscards/helper/helper_function.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      final response = await http.post(url, body: body, headers: headers);
      final responseData = jsonDecode(response.body);

      if (responseData['status'] == '200' || responseData['status'] == '201') {
        if (responseData['status'] == '201') {
          String xpub1 = responseData['data']['xpub1'];
          String xpub2 = responseData['data']['xpub2'];
          await HelperFunction.saveUserEmailSF(email);
          await HelperFunction.saveXpub1SF(xpub1);
          await HelperFunction.saveXpub2SF(xpub2);
          debugPrint(email);
          debugPrint(password);
          debugPrint("$responseData");
        } else {
          // Authenticated, process user data

          await _processUserData(responseData['details']);
          debugPrint(email);
          debugPrint(password);
          debugPrint("$responseData");
        }
        return responseData;
      } else {
        throw ('Login failed: ${responseData['data']['message'] ?? 'Something went wrong'}');
      }
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future<void> _processUserData(Map<String, dynamic> userDetails) async {
    await HelperFunction.saveUserEmailSF(userDetails['email']);
    await HelperFunction.saveSpaceNameSF(userDetails['brand']);

    if (userDetails['banners'] != null) {
      await _saveBanners(userDetails['banners']);
    }
  }

  // You might want to add a method to save banners if needed
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
        await _saveAuthId(responseData['data']['authid']);
        return responseData;
      } else {
        throw Exception(
            responseData['data']['message'] ?? 'Authentication failed');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<String?> getAuthId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authId');
  }

  Future<void> _saveAuthId(String authId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authId', authId);
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
