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
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height /
                  2, // Half of the screen height
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/ss.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const Positioned.fill(
                    child: FractionalTranslation(
                      translation: Offset(0.0, 0.0),
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
            ),
            SizedBox(
              height: 40.h,
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
