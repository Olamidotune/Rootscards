
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:rootscards/helper/helper_function.dart';

class AuthServices {
  ///getDeviceID

  Future<void> getDeviceID() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId = "";
    String entry = "";
    String deviceName = "";
    String deviceType = "";
    String deviceModel = "";

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
        entry = androidInfo.brand;
        deviceName = androidInfo.device;
        deviceType = androidInfo.model;
        deviceModel = androidInfo.product;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor!;
        entry = iosInfo.model;
        deviceName = iosInfo.name;
        deviceType = iosInfo.model;
        deviceModel = iosInfo.systemName;
      }
    } catch (e) {
      throw Exception('Failed to get device information: $e');
    }
    debugPrint(deviceId);
    debugPrint(entry);
    debugPrint(deviceName);
    debugPrint(deviceType);
    debugPrint(deviceModel);

    await HelperFunction.saveDeviceIDSF(deviceId);
    await HelperFunction.saveDeviceEntry(entry);
    await HelperFunction.saveDeviceNameSF(deviceName);
    await HelperFunction.saveDeviceTypeSF(deviceType);
    await HelperFunction.saveDeviceModel(deviceModel);
  }

  //   Future<Map<String, dynamic>> logins(String email, String password) async {
  //   String deviceId = await HelperFunction.getDeviceIDfromSF() ?? "N/A";
  //   final url = Uri.parse("$baseUrl/");
  //   final body = jsonEncode({
  //     'email': email,
  //     'password': password,
  //   });

  //   final headers = {
  //     'deviceid': deviceId,
  //     'Content-Type': 'application/json',
  //   };

  //   try {
  //     final response = await http.post(url, body: body, headers: headers);
  //     final responseData = jsonDecode(response.body);

  //     if (responseData['status'] == '200' || responseData['status'] == '201') {
  //       if (responseData['status'] == '201') {
  //         String xpub1 = responseData['data']['xpub1'];
  //         String xpub2 = responseData['data']['xpub2'];
  //         await HelperFunction.saveUserEmailSF(email);
  //         await HelperFunction.saveXpub1SF(xpub1);
  //         await HelperFunction.saveXpub2SF(xpub2);
  //         debugPrint(email);
  //         debugPrint(password);
  //         debugPrint("$responseData");
  //       } else {
  //         // Authenticated, process user data
  //         await _processUserData(responseData['details']);

  //         debugPrint(email);
  //         debugPrint(password);
  //         debugPrint(responseData);
  //       }
  //       return responseData;
  //     } else if (responseData['status'] == '401') {
  //       throw 'Incorrect credentials';
  //     } else {
  //       throw ('Login failed: ${responseData['data']['message'] ?? 'Something went wrong'}');
  //     }
  //   } catch (e) {
  //     throw 'Something went wrong.';
  //   }
  // }

  // Future<void> _processUserData(Map<String, dynamic> userDetails) async {
  //   await HelperFunction.saveUserEmailSF(userDetails['email']);
  //   await HelperFunction.saveSpaceNameSF(userDetails['brand']);
  //   await HelperFunction.userLoggedInStatus() == true;

  //   if (userDetails['banners'] != null) {
  //     await _saveBanners(userDetails['banners']);
  //   }
  // }

  // // You might want to add a method to save banners if needed
  // Future<void> _saveBanners(List<dynamic> banners) async {
  //   // Implement banner saving logic here
  //   // This could involve saving to SharedPreferences or another storage method
  // }

}
