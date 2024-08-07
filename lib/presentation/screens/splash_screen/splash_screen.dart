import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:rootscards/services/auth_services.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash_screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    });
    authServices.getDeviceID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: .35.sh,
                ),
                SvgPicture.asset(
                  "assets/svg/logo.svg",
                  height: .1.sh,
                  color: BLACK,
                ),
                AppSpacing.verticalSpaceSmall,
                Text(
                  "RootsCards",
                  style: context.textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 30.sp,
                      fontFamily: "LoveYaLikeASister"),
                ),
                SizedBox(
                  height: .35.sh,
                ),
                Text(
                  "By Rootshive 1.01",
                  style: context.textTheme.bodySmall?.copyWith(
                    color: GREY,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getDeviceID() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId = "";
    // ignore: unused_local_variable
    String entry = "";
    String deviceName = "";
    String deviceType = "";
    String deviceModel = "";

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
    debugPrint(deviceId);
    debugPrint(deviceName);
    debugPrint(deviceType);
    debugPrint(deviceModel);
  }
}
