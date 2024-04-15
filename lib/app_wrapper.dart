
import 'package:flutter/material.dart';
import 'package:rootscards/presentation/screens/auth/sign_in.dart';
import 'package:rootscards/presentation/screens/splash_screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppWrapper extends StatefulWidget {
  static const String routeName = "Wrapper";
  const AppWrapper({Key? key}) : super(key: key);

  @override
  _AppWrapperState createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    checkSignInStatus();
  }

  Future<void> checkSignInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    setState(() {
      _isSignedIn = email != null; // Check if email exists in SharedPreferences
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isSignedIn ? const SignInScreen() : const SplashScreen();
  }
}
