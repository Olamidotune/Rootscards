// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/helper/helper_function.dart';
import 'package:rootscards/presentation/screens/auth/passowrd/password_recovery.dart';
import 'package:rootscards/presentation/screens/space/space_screen.dart';
import 'package:rootscards/presentation/screens/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpScreen extends StatefulWidget {
  static const String routeName = "sign_in_auth_screen";

  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _busy = false;
  String? email;

  @override
  void initState() {
    super.initState();
    _getEmail();
  }

  _getEmail() async {
    await HelperFunction.getUserEmailfromSF().then((value) {
      setState(() {
        email = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
            ),
            iconSize: 18.h,
          ),
          title: Text(
            "OTP",
            style: context.textTheme.bodyMedium?.copyWith(
              color: BLACK,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.info_outline),
              iconSize: 18.h,
            ),
          ]),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: height,
            padding: EdgeInsets.only(
              top: height <= 550 ? 10 : 20,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Enter Confrimation Code",
                  style: context.textTheme.headlineLarge!.copyWith(
                      fontFamily: "LoveYaLikeASister", fontSize: 28.sp),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
                AppSpacing.verticalSpaceSmall,
                Text("Enter the 4-digit OTP code. We've just send to",
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: GREY,
                    )),
                Text(email ?? "N/A",
                    style: context.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                AppSpacing.verticalSpaceHuge,
                Center(
                  child: PinCodeTextField(
                    isCupertino: true,
                    keyboardType: TextInputType.number,
                    hideCharacter: false,
                    controller: _otpController,
                    autofocus: false,
                    pinBoxHeight: 50.h,
                    pinBoxWidth: 70.w,
                    maxLength: 4,
                    onDone: (String value) {
                      debugPrint('Entered OTP: $value');
                      // _authenticateDevice(value);
                    },
                    pinTextStyle: TextStyle(fontSize: 20),
                    pinBoxDecoration: (borderColor, pinBoxColor,
                        {double borderWidth = 0, double? radius}) {
                      return BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: GREY2,
                          width: borderWidth,
                        ),
                        color: Colors.transparent,
                      );
                    },
                  ),
                ),
                AppSpacing.verticalSpaceMedium,
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Didn't receive OTP?",
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: GREY,
                      ),
                      children: [
                        TextSpan(
                            text: " Resend",
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height <= MIN_SUPPORTED_SCREEN_HEIGHT
                      ? .43 * height
                      : height * .46,
                ),
                Button(
                  busy: _busy,
                  pill: true,
                  disabledTextColor: BLACK,
                  "Confirm",
                  onPressed: () {
                    Navigator.of(context).pushNamed(PasswordRecovery.routeName);
                    // _authenticateDevice(_otpController.text);
                  },
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
    setState(() {
      setState(() => _busy = true);
    });
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
      http.Response response = await http
          .post(
            Uri.parse(otpEndpoint),
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
          debugPrint('Auth Successful: $responseData');
          String authid = responseData['data']['authid'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('authid', authid);
          await prefs.setBool("isAuth", true);
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              backgroundColor: Colors.white,
              shadowColor: Colors.green,
              elevation: 2,
              leading: Icon(
                Icons.check,
                color: Colors.green,
              ),
              content: RichText(
                text: TextSpan(
                  text: "Successful",
                  style: TextStyle(
                      color: BLACK,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  children: const [
                    TextSpan(
                      text: "\nYour changes have been saved sucessfully",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.normal,
                          fontSize: 11),
                    ),
                  ],
                ),
              ),
              actions: const [
                Icon(
                  Icons.close,
                ),
              ],
            ),
          );
          Future.delayed(Duration(seconds: 1), () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            Navigator.of(context).pushNamedAndRemoveUntil(
              SpaceScreen.routeName,
              (_) => false,
            );
          });
          setState(() => _busy = false);
        } else {
          debugPrint('Auth Failed: $responseData');
          String errorMessage = responseData['data']['message'];
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              backgroundColor: Colors.white,
              shadowColor: Colors.red,
              elevation: 2,
              leading: Icon(
                Icons.error,
                color: Colors.red,
              ),
              content: Text(errorMessage),
              actions: const [
                Icon(
                  Icons.close,
                ),
              ],
            ),
          );
          Future.delayed(Duration(seconds: 3), () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          });
          setState(() => _busy = false);
        }
      } else {
        debugPrint(
            'Failed to authenticate device. Status code: ${response.statusCode}');
        setState(() => _busy = false);
      }
    } catch (e) {
      debugPrint('Failed to authenticate device: $e');
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          backgroundColor: Colors.white,
          shadowColor: Colors.red,
          elevation: 2,
          leading: Icon(
            Icons.error,
            color: Colors.red,
          ),
          content: RichText(
            text: const TextSpan(
              text: "Oops!",
              style: TextStyle(
                  color: BLACK,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              children: [
                TextSpan(
                  text: "\nCheck your internet connection and try again.",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.normal,
                      fontSize: 11),
                ),
              ],
            ),
          ),
          actions: const [
            Icon(
              Icons.close,
            ),
          ],
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      });
      setState(() => _busy = false);
    }
  }
}
