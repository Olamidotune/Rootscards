// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:rootscards/presentation/screens/auth/sign_up.dart';
import 'package:rootscards/presentation/screens/onboarding/onboarding_one.dart';
import 'package:rootscards/presentation/screens/onboarding/onboarding_two.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = "onboarding_screen";

  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: 2,
        itemBuilder: (context, index) {
          return index == 0
              ? OnBoardingScreenOne(
                  onTap: nextPage,
                )
              : OnBoardingScreenTwo(
                  onTap: () => navigateToSignInPage(context),
                );
        },
      ),
    );
  }

  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void navigateToSignInPage(BuildContext context) {
    Navigator.of(context).popAndPushNamed(SignUpScreen.routeName);
  }
}
