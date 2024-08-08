import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/helper/helper_function.dart';
import 'package:rootscards/presentation/screens/auth/sign_in/sign_in.dart';
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
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();

    checkSignInStatus();
    Timer(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  isAuthenticated ? SignInScreen() : OnboardingScreen()),
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
                AppSpacing.verticalSpaceLarge,
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

  Future<void> checkSignInStatus() async {
    bool authenticatedUser = await HelperFunction.userLoggedInStatus() ?? false;
    setState(() {
      isAuthenticated = authenticatedUser;
    });
  }
}
