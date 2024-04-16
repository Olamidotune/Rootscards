// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rootscards/config/dimensions.dart';
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
            SizedBox(
              height: MediaQuery.of(context).size.height /
                  2, // Half of the screen height
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/yees.png",
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context)
                        .size
                        .width, // Adjust width to fill the screen
                    height: MediaQuery.of(context).size.height /
                        2, // Half of the screen height
                  ),
                  Positioned.fill(
                    child: FractionalTranslation(
                      translation: Offset(0.0, 0.0),
                      child: Image.asset(
                        "assets/images/circle.png",
                        fit: BoxFit
                            .contain, // Ensure the image fits within the container
                        width: MediaQuery.of(context).size.width *
                            0.5, // Adjust width dynamically
                        height: MediaQuery.of(context).size.height *
                            0.5, // Adjust height dynamically
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: FractionalTranslation(
                      translation: Offset(0.0, 0.0),
                      child: Center(
                        child: Image.asset(
                          "assets/images/doodle_stroke.png",
                          width: MediaQuery.of(context).size.width *
                              (180 / 80), // Adjust width dynamically
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: FractionalTranslation(
                      translation:
                          Offset(0.0, 0.25), // Adjust vertical position
                      child: Center(
                        child: Image.asset(
                          "assets/images/woman.png",
                          width: MediaQuery.of(context)
                              .size
                              .width, // Adjust width dynamically
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height <=
                      MIN_SUPPORTED_SCREEN_HEIGHT
                  ? MediaQuery.of(context).size.height * 0.1
                  : MediaQuery.of(context).size.height * 0.15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Stand Out!.",
                  style: context.textTheme.titleLarge?.copyWith(
                    fontSize: 36,
                    color: Colors.black,
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
                  "Optimize what works with Insights to know and understand your audience, allowing you fly high.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height <=
                      MIN_SUPPORTED_SCREEN_HEIGHT
                  ? MediaQuery.of(context).size.height * 0.12
                  : MediaQuery.of(context).size.height * 0.09,
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
