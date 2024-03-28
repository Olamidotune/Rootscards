// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/presentation/screens/auth/forgot_password.dart';
import 'package:rootscards/presentation/screens/auth/sign_in.dart';
import 'package:rootscards/presentation/screens/auth/device_auth_screen.dart';
import 'package:rootscards/presentation/screens/auth/sign_up.dart';
import 'package:rootscards/presentation/screens/onboarding/onboarding.dart';
import 'package:rootscards/presentation/screens/onboarding/onboarding_one.dart';
import 'package:rootscards/presentation/screens/onboarding/onboarding_two.dart';
import 'package:rootscards/presentation/screens/space/space_screen.dart';
import 'package:rootscards/presentation/screens/splash_screen/splash_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'McLaren',
            // scaffoldBackgroundColor: BLACK,
            useMaterial3: true,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(
                fontSize: 14,
                // color: Colors.red,
              ),
              bodySmall: TextStyle(
                fontSize: 12,
                color: Colors.amber,
              ),
              titleLarge: TextStyle(color: Colors.black),
              titleMedium: TextStyle(color: Colors.black),
              titleSmall: TextStyle(color: Colors.black),
              displayLarge: TextStyle(color: Colors.black),
              displayMedium: TextStyle(color: Colors.black),
              displaySmall: TextStyle(color: Colors.black),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            fontFamily: 'McLaren',
            textTheme: const TextTheme(
              bodySmall: TextStyle(color: BLACK),
              bodyLarge: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              bodyMedium: TextStyle(color: BLACK),
              titleLarge: TextStyle(color: BLACK),
              titleMedium: TextStyle(color: BLACK),
              titleSmall: TextStyle(color: BLACK),
              displayLarge: TextStyle(color: BLACK),
              displayMedium: TextStyle(color: BLACK),
              displaySmall: TextStyle(color: BLACK),
            ),
            scaffoldBackgroundColor: Colors.black,
          ),
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
            OnBoardingScreenOne.routeName: (context) =>
                const OnBoardingScreenOne(),
            OnBoardingScreenTwo.routeName: (context) =>
                const OnBoardingScreenTwo(),
            SignUpScreen.routeName: (context) => const SignUpScreen(),
            SignInScreen.routeName: (context) => SignInScreen(),
            ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
            SignInAuthScreen.routeName: (context) => const SignInAuthScreen(),
            SpaceScreen.routeName:(context) => const SpaceScreen()
          },
        );
      },
    );
  }
}
