// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/presentation/screens/space/space_screen.dart';
import 'package:rootscards/presentation/screens/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class SignInAuthScreen extends StatefulWidget {
  static const String routeName = "sign_in_auth_screen";

  const SignInAuthScreen({super.key});

  @override
  State<SignInAuthScreen> createState() => _SignInAuthScreenState();
}

class _SignInAuthScreenState extends State<SignInAuthScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _busy = false;

  SharedPreferences? preferences;

  String? email;

  @override
  void initState() {
    super.initState();
    _getEmail();
  }

  // Method to get email from SharedPreferences
  Future<void> _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Device Authorization",
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "We noticed you are signing into your rootshive account from a device or location we do not recognize.To confirm this is you sent an email with an authentication code to $email",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.sp),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Authorization Code *",
                   style: TextStyle(fontSize: 10.sp),
                ),
                SizedBox(
                  height: 4.h,
                  
                ),
                PinCodeTextField(
                  isCupertino: true,
                  keyboardType: TextInputType.number,
                  hideCharacter: true,
                  controller: _otpController,
                  autofocus: true,
                  pinBoxHeight: 50,
                  pinBoxWidth: 50,
                  maxLength: 4,
                  onDone: (String value) {
                    debugPrint('Entered OTP: $value');
                    _authenticateDevice(value);
                  },
                  pinTextStyle: TextStyle(fontSize: 20),
                  pinBoxDecoration:
                      ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Button(
                  busy: _busy,
                  "Confirm",
                  onPressed: () {
                    _authenticateDevice(_otpController.text);
                    setState(() => _busy = !_busy);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 9,
                ),
                Text(
                  "Can't find the authorization code? check the spam\nfolder or sign in again to get a fresh code.",
                  style: TextStyle(fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _authenticateDevice(String otp) async {
    if (_busy) return;

    setState(() => _busy = true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? xpub1 = prefs.getString('xpub1');
    String? xpub2 = prefs.getString('xpub2');

    if (xpub1 == null || xpub2 == null) {
      debugPrint('xpub1 and xpub2 not found in shared preferences');
      setState(() => _busy = false); // Reset busy state
      return;
    }

    String deviceId = "";
    String entry = "";
    String deviceName = "";
    String deviceType = "";
    String deviceModel = "";

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

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
      debugPrint('Failed to get device information: $e');
      setState(() => _busy = false); // Reset busy state
      return;
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

    String otpEndpoint = "https://api.idonland.com/user/authorizeDevice";

    try {
      http.Response response = await http.post(
        Uri.parse(otpEndpoint),
        headers: {
          HttpHeaders.authorizationHeader:
              'Basic ${base64Encode(utf8.encode("$xpub1:$xpub2"))}',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: encodedBody,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        String status = responseData['status'];

        if (status == "200") {
          debugPrint('Auth Successful: $responseData');
          String authid = responseData['data']['authid'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('authid', authid);

          setState(() => _busy = false);
          Navigator.of(context).popAndPushNamed(SpaceScreen.routeName);
        } else {
          debugPrint('Auth Failed: $responseData');
          String errorMessage = responseData['data']['message'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(errorMessage),
              duration: const Duration(seconds: 2),
            ),
          );
          setState(() => _busy = false);
        }
      } else {
        debugPrint(
            'Failed to authenticate device. Status code: ${response.statusCode}');
        setState(() => _busy = false);
      }
    } catch (e) {
      debugPrint('Failed to authenticate device: $e');
      setState(() => _busy = false);
    }
  }
}
