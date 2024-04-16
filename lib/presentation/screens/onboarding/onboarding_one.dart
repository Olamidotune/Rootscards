// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/presentation/screens/widgets/next_button.dart';
import 'package:sizer/sizer.dart';

class OnBoardingScreenOne extends StatelessWidget {
  final Function()? onTap;
  static const String routeName = "onboarding_one";
  const OnBoardingScreenOne({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
          SizedBox(
  height: MediaQuery.of(context).size.height / 2, // Half of the screen height
  child: Stack(
    children: [
      Image.asset(
        "assets/images/ss.png",
        fit: BoxFit.cover, // Ensure the image covers the entire container
        width: MediaQuery.of(context).size.width, // Adjust width to fill the screen
      ),
      Positioned(
        bottom: 50,
        child: Image.asset("assets/images/cube.png"),
      ),
      Positioned(
        top: 90,
        left: MediaQuery.of(context).size.width * 0.70, // Adjust left position dynamically
        child: Image.asset(
          "assets/images/round.png",
          width: MediaQuery.of(context).size.width * 0.3, // Adjust width dynamically
          height: MediaQuery.of(context).size.width * 0.3 * (180 / 80), // Maintain aspect ratio
        ),
      ),
      Positioned.fill(
        child: FractionalTranslation(
          translation: Offset(0.0, 0.0),
          child: Center(
            child: Image.asset(
              "assets/images/man.png",
              height:MediaQuery.of(context).size.height ,
              width: MediaQuery.of(context).size.width , // Adjust width dynamically
            ),
          ),
        ),
      ),
    ],
  ),
),

            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text("A creators \nhandy tool.",
                    style: context.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 36,
                    )),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 95,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "The #1 one-for-all link for all creators,\nbrands and businesses .",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            SizedBox(
             height: MediaQuery.of(context).size.height <=
                        MIN_SUPPORTED_SCREEN_HEIGHT
                    ? MediaQuery.of(context).size.height * 0.12
                    : MediaQuery.of(context).size.height * 0.15,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: NextButton(
                onTap: onTap,
              ),
            )
          ],
        ),
      ),
    );
  }
}
