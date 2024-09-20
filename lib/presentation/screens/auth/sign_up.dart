// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:rootscards/presentation/screens/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignUpScreen extends StatefulWidget {
  static const String routeName = "sign_up screen";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
          title: Text(
            "Sign Up",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.info_outline),
            ),
          ]),
        body: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign Up",
                style: context.textTheme.titleLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 45,
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              RichText(
                text: TextSpan(
                  text: "Have an account already?",
                  style: const TextStyle(
                      fontFamily: "McLaren", color: Colors.black),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context)
                            .popAndPushNamed(SignInScreen.routeName),
                      text: " Sign in",
                      style: const TextStyle(
                        color: THEME,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Form(
                key: _formKey,
                child: AutofillGroup(
                  child: Text("data")
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Button(
                busy: _busy,
                "Create my account",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _signUp(
                        _emailController.text,
                        _fullNameController.text,
                        _passwordController.text,
                        _passwordController.text,
                        "individual",
                        "nil",
                        context);
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "By tapping create my account and using\nRootscards you agree to our Terms of Service&\n Privacy Policy.",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height <=
                        MIN_SUPPORTED_SCREEN_HEIGHT
                    ? 11
                    : MediaQuery.of(context).size.height * 0.1,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "rootcards.com",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> _signUp(
    String email,
    String fullName,
    String password,
    String phoneNumber,
    String account,
    String referer,
    BuildContext context,
  ) async {
    String apiUrl = 'https://api.idonland.com/signup';

    if (_busy) return;
    if (_formKey.currentState!.validate()) return;
    setState(() {
      setState(() => _busy = true);
    });

    Timer(const Duration(minutes: 1), () {
      if (_busy) {
        ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            backgroundColor: Colors.white,
            shadowColor: Colors.red,
            elevation: 2,
            leading: const Icon(
              Icons.error,
              color: Colors.red,
            ),
            content: RichText(
              text: const TextSpan(
                text: "Oops!",
                style: TextStyle(
                  color: BLACK,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                children: [
                  TextSpan(
                    text: "\nRequest timed out. Please try again.",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.normal,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        );
        Future.delayed(const Duration(seconds: 3), () {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        });
        setState(() => _busy = false);
      }
    });

    Map<String, String> requestBody = {
      'email': email,
      'fullName': fullName,
      'password': password,
      'phoneNumber': phoneNumber,
      'account': account,
      'referer': referer,
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        String status = responseData['status'];
        setState(() => _busy = false);
        if (status == '200') {
          debugPrint('Sign Up Successful: $responseData');
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              backgroundColor: Colors.white,
              shadowColor: Colors.green,
              elevation: 2,
              leading: const Icon(
                Icons.check,
                color: Colors.green,
              ),
              content: RichText(
                text: const TextSpan(
                  text: "Successful",
                  style: TextStyle(
                      color: BLACK,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  children: [
                    TextSpan(
                      text: "\nYour account was created successfully",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.normal,
                          fontSize: 11),
                    ),
                  ],
                ),
              ),
              actions: const [
                Icon(
                  Icons.close,
                ),
              ],
            ),
          );
          Future.delayed(const Duration(seconds: 2), () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            Navigator.of(context).popAndPushNamed(
              SignInScreen.routeName,
            );
          });
          setState(() => _busy = false);
        } else {
          // User is not authenticated, handle the error
          debugPrint('Sign Up Failed. Status Code: $status');
          String errorMessage = responseData['data']['message'];
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              backgroundColor: Colors.white,
              shadowColor: Colors.red,
              elevation: 2,
              leading: const Icon(
                Icons.error,
                color: Colors.red,
              ),
              content: Text(errorMessage),
              actions: const [
                Icon(
                  Icons.close,
                ),
              ],
            ),
          );
          Future.delayed(const Duration(seconds: 2), () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          });
          setState(() => _busy = false);
        }
      } else {
        // Handle other status codes
        debugPrint('Sign Up Failed. Status Code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Something went wrong"),
            duration: Duration(seconds: 2),
          ),
        );
        setState(() => _busy = false);
      }
    } catch (e) {
      debugPrint('Something went wrong: $e');

      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          backgroundColor: Colors.white,
          shadowColor: Colors.red,
          elevation: 2,
          leading: const Icon(
            Icons.error,
            color: Colors.red,
          ),
          content: RichText(
            text: const TextSpan(
              text: "Oops!",
              style: TextStyle(
                  color: BLACK,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              children: [
                TextSpan(
                  text: "\nCheck your internet connection and try again.",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.normal,
                      fontSize: 11),
                ),
              ],
            ),
          ),
          actions: const [
            Icon(
              Icons.close,
            ),
          ],
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      });

      setState(() => _busy = false);
    }
  }
}
