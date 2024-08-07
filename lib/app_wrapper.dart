import 'package:flutter/material.dart';
import 'package:rootscards/helper/helper_function.dart';
import 'package:rootscards/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:rootscards/presentation/screens/splash_screen/splash_screen.dart';


class AppWrapper extends StatefulWidget {
  static const String routeName = "Wrapper";
  const AppWrapper({Key? key}) : super(key: key);

  @override
  AppWrapperState createState() => AppWrapperState();
}

class AppWrapperState extends State<AppWrapper> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    checkSignInStatus();
  }

  Future<void> checkSignInStatus() async {
    String? email = await HelperFunction.getUserEmailfromSF();
    setState(() {
      _isSignedIn = email != null; // Check if email exists in SharedPreferences
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isSignedIn ? const SignInScreen() : const SplashScreen();
  }
}
