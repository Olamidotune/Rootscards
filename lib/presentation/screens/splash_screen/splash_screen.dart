import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/presentation/screens/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash_screen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TestOnboarding()),
        );
      }
    });
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
                  height: MediaQuery.of(context).size.height / 2.5,
                ),
                SvgPicture.asset(
                  "assets/svg/logo.svg",
                  height: 60.h,
                  color: BLACK,
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "RootsCards",
                  style: context.textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 30.sp,
                      fontFamily: "LoveYaLikeASister"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
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
}
