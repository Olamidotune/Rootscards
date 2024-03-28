// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/presentation/screens/widgets/get_started_button.dart';
import 'package:sizer/sizer.dart';

class OnBoardingScreenTwo extends StatelessWidget {
  static const String routeName = "onboarding_two";

  final Function()? onTap;
  const OnBoardingScreenTwo({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/images/yees.png",
                  fit: BoxFit.fitWidth,
                ),
                Positioned.fill(
                  child: FractionalTranslation(
                    translation: Offset(0.0, 0.0),
                    child: Image.asset(
                      "assets/images/circle.png",
                    ),
                  ),
                ),
                Positioned.fill(
                  child: FractionalTranslation(
                    translation: Offset(0.0, 0.0),
                    child: Center(
                      child: Image.asset("assets/images/doodle_stroke.png"),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: FractionalTranslation(
                    translation: Offset(
                      0.0,
                      0.25,
                    ),
                    child: Center(
                      child: Image.asset("assets/images/woman.png"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: GestureDetector(
                  onTap: () {
                    // getDeviceInformation();
                  },
                  child: Text(
                    "Stand Out!.",
                    style: context.textTheme.titleLarge?.copyWith(
                      fontSize: 36,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Optimize what works with Insights to know\nand understand your audience, allowing\nyou fly high.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GetStartedButton(
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
