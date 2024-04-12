import 'package:flutter/material.dart';
import 'package:rootscards/presentation/screens/auth/sign_in.dart';
import 'package:rootscards/presentation/screens/splash_screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  //Keys

  static String userNamekey = 'USERNAMEKEY';
  static String userEmailKey = 'EMAILKEY';
  static String PhoneNumberKey = "PHONENUMBERKEY";
  static String xpub1Key = "XPUB1";
  static String xpub2Key = "XPUB2";
  static String userLoggedInKey = 'LOGGEDINKEY';
  static String spaceNameKey = 'SPACENAMEKEY';

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  static Future<bool> saveXpub1(String xpub1) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(xpub1Key, xpub1);
  }

  static Future<bool> saveXpub2(String xpub2) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(xpub2Key, xpub2);
  }

  static Future<bool?> saveSpaceName(String spaceName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(spaceNameKey, spaceName);
  }

  static Future<bool?> userLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<String?> getUserEmailfromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<String?> getUserNamefromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNamekey);
  }

  static Future<String?> getXpub1fromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(xpub1Key);
  }

  static Future<String?> getXpub2fromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(xpub2Key);
  }
}

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
