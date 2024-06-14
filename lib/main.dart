// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rootscards/app_wrapper.dart';
import 'package:rootscards/presentation/get_started_screen.dart';
import 'package:rootscards/presentation/screens/auth/forgot_password.dart';
import 'package:rootscards/presentation/screens/auth/sign_in.dart';
import 'package:rootscards/presentation/screens/auth/device_auth_screen.dart';
import 'package:rootscards/presentation/screens/auth/sign_up.dart';

import 'package:rootscards/presentation/screens/onboarding/onboarding_screen.dart';
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
            fontFamily: 'Lato',
            // scaffoldBackgroundColor: BLACK,
            useMaterial3: true,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(
                fontSize: 14,
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
          // darkTheme: ThemeData(
          //   brightness: Brightness.dark,
          //   fontFamily: 'McLaren',
          //   textTheme: const TextTheme(
          //     bodySmall: TextStyle(color: Colors.white),
          //     bodyLarge: TextStyle(
          //       color: Colors.white,
          //       fontWeight: FontWeight.w500,
          //     ),
          //     bodyMedium: TextStyle(color: Colors.white),
          //     titleLarge: TextStyle(color: Colors.white),
          //     titleMedium: TextStyle(color: Colors.white),
          //     titleSmall: TextStyle(color: Colors.white),
          //     displayLarge: TextStyle(color: Colors.white),
          //     displayMedium: TextStyle(color: Colors.white),
          //     displaySmall: TextStyle(color: Colors.white),
          //   ),
          //   scaffoldBackgroundColor: Colors.white,
          // ),
          home: AppWrapper(),
          routes: {
            SplashScreen.routeName: (context) => SplashScreen(),
            TestOnboarding.routeName: (context) => TestOnboarding(),
            SignUpScreen.routeName: (context) => SignUpScreen(),
            SignInScreen.routeName: (context) => SignInScreen(),
            GetStartedScreen.routeName: (context) => GetStartedScreen(),
            ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
            SignInAuthScreen.routeName: (context) => SignInAuthScreen(),
            SpaceScreen.routeName: (context) => SpaceScreen()
          },
        );
      },
    );
  }
}
