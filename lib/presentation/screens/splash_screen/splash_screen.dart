import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rootscards/presentation/screens/onboarding/onboarding.dart';

import 'package:sizer/sizer.dart';

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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  OnBoardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage("assets/images/ss.png"),
                        fit: BoxFit.fill),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.red.withOpacity(0.5),
                        Colors.purple,
                      ],
                    ),
                  ),
                  child: Image.asset(
                    "assets/images/ss.png",
                  ),
                ),
                const Positioned.fill(
                  child: FractionalTranslation(
                    translation: Offset(0.0, 0.3),
                    child: Center(
                      child: Text(
                        "rootscards",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            const Text(
              "Be Seen, Be Heard. Show off \n All of you, in one Link.",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
