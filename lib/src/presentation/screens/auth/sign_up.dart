// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'sign_in/sign_in.dart';
import 'package:rootscards/src/shared/widgets/button.dart';
import 'package:rootscards/src/shared/widgets/small_social_button.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Create Account",
                      style: context.textTheme.titleLarge?.copyWith(
                        color: Colors.black,
                        fontSize: 45,
                      ),
                    ),
                  ),
                  AppSpacing.verticalSpaceLarge,
                  Form(
                    key: _formKey,
                    child: AutofillGroup(
                      child: CustomTextField(
                        textInputAction: TextInputAction.go,
                        hintText: "Enter your email here",
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (EmailValidator.validate(value?.trim() ?? "")) {
                            return null;
                          }
                          return "Please provide a valid email address";
                        },
                      ),
                    ),
                  ),
                  AppSpacing.verticalSpaceSmall,
                  Button(
                    pill: true,
                    busy: _busy,
                    "Continue",
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
                    height: 0.25.sh,
                  ),
                  Text(
                    "Or sign up with",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                  AppSpacing.verticalSpaceSmall,
                  Row(
                    children: [
                      Expanded(
                        child: SmallSocialButton(
                          iconName: "facebook",
                          onPressed: () {},
                        ),
                      ),
                      AppSpacing.horizontalSpaceSmall,
                      Expanded(
                        child: SmallSocialButton(
                          iconName: "google",
                          onPressed: () {},
                        ),
                      ),
                      AppSpacing.horizontalSpaceSmall,
                      Expanded(
                        child: SmallSocialButton(
                          iconName: "apple",
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.verticalSpaceMedium,
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "By continuing, you agree to Pipel's ",
                      style: TextStyle(
                          fontFamily: "lato",
                          fontSize: 13.sp,
                          color: Colors.grey),
                      children: [
                        TextSpan(
                          text: "Terms of Service\n",
                          style: TextStyle(
                              fontFamily: "lato",
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: Colors.black),
                        ),
                        TextSpan(
                          text: " and ",
                          style: TextStyle(
                              fontFamily: "lato",
                              fontSize: 13.sp,
                              color: Colors.grey),
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                              fontFamily: "lato",
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  AppSpacing.verticalSpaceHuge,
                  // SizedBox(
                  //   height: 0.90 * height <= 700
                  //       ? .03.h * height
                  //       : height * .19.h,
                  // ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(
                            fontFamily: "lato",
                            fontSize: 13.sp,
                            color: Colors.grey),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context).pushNamed(
                                    SignInScreen.routeName,
                                  ),
                            text: " Login",
                            style: TextStyle(
                                fontFamily: "lato",
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                                color: Colors.black),
                          ),
                        ]),
                  ),
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
