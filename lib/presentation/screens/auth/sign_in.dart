// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/presentation/screens/auth/device_auth_screen.dart';
import 'package:rootscards/presentation/screens/auth/forgot_password.dart';
import 'package:rootscards/presentation/screens/auth/sign_up.dart';
import 'package:rootscards/presentation/screens/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = "sign_in screen";

  const SignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _busy = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            alignment: Alignment.center,
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign In",
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
                                  .popAndPushNamed(SignUpScreen.routeName),
                            text: " Sign up",
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
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Email",
                                style: TextStyle(
                                  color: BLACK,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (EmailValidator.validate(
                                    value?.trim() ?? "")) {
                                  return null;
                                }
                                return "Please provide a valid email address";
                              },
                              style: const TextStyle(color: BLACK),
                              autofillHints: const [AutofillHints.email],
                              decoration: InputDecoration(
                                prefixIcon: Image.asset(
                                    "assets/images/message-icon.png"),
                                hintText: "enter your email",
                                hintStyle:
                                    const TextStyle(color: Colors.black26),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      7,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Password",
                                  style: TextStyle(fontSize: 12),
                                ),
                                GestureDetector(
                                    onTap: () => Navigator.of(context)
                                        .pushNamed(
                                            ForgotPasswordScreen.routeName),
                                    child: const Text(
                                      "forgot password?",
                                      style: TextStyle(fontSize: 12),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _passwordController,
                              focusNode: _passwordFocusNode,
                              textInputAction: TextInputAction.go,
                              obscureText: _obscurePassword,
                              onFieldSubmitted: (_) => _signIn(
                                  _emailController.text,
                                  _passwordController.text,
                                  context),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please provide a password.";
                                }
                                return null;
                              },
                              style: const TextStyle(),
                              autofillHints: const [AutofillHints.email],
                              decoration: InputDecoration(
                                prefixIcon: Image.asset(
                                    "assets/images/password-icon.png"),
                                suffixIcon: IconButton(
                                    onPressed: () => setState(() =>
                                        _obscurePassword = !_obscurePassword),
                                    icon: _obscurePassword
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off)),
                                hintText: "enter your password",
                                hintStyle:
                                    const TextStyle(color: Colors.black26),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      7,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Button(
                      busy: _busy,
                      "login to your account",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _signIn(
                            _emailController.text,
                            _passwordController.text,
                            context,
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Text(
                      "A creators handy tool..\nShow off all of you, in one link.",
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
              
                  SizedBox(
                height: MediaQuery.of(context).size.height <=
                        MIN_SUPPORTED_SCREEN_HEIGHT
                    ? 11
                    : MediaQuery.of(context).size.height / 2.2,
              ),
                    Text(
                      "rootcards.com",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  
  Future<void> _signIn(
      String email, String password, BuildContext context) async {
    if (_busy) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    String apiUrl = 'https://api.idonland.com/';
    Map<String, String> requestBody = {
      'email': email,
      'password': password,
    };
    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        String status = responseData['status'];
        if (status == "201") {
          String xpub1 = responseData['data']['xpub1'];
          String xpub2 = responseData['data']['xpub2'];
          debugPrint('Sign In Successful: $responseData');
          debugPrint('Xpub1: $xpub1');
          debugPrint('Xpub2: $xpub2');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('xpub1', xpub1);
          await prefs.setString('xpub2', xpub2);
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
                      text: "\nWe sent next steps to your email",
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
          setState(() => _busy = false);
          Future.delayed(const Duration(seconds: 3), () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            Navigator.of(context).popAndPushNamed(
              SignInAuthScreen.routeName,
            );
          });
        } else {
          setState(() => _busy = false);
          debugPrint('Sign Up Failed. Status Code: $responseData');
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
              content: RichText(
                text: TextSpan(
                  text: "An error occurred",
                  style: const TextStyle(
                      color: BLACK,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  children: [
                    TextSpan(
                      text: "\n$errorMessage",
                      style: const TextStyle(
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
        }
      } else {
        debugPrint('Sign In Failed. Status Code: ${response.statusCode}');
        debugPrint('Error Message: ${response.body}');
        setState(() => _busy = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Email and Password do not match"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      setState(() => _busy = false);
      debugPrint('Something went wrong: $e');
      ScaffoldMessenger.of(context).showMaterialBanner(
        const MaterialBanner(
          backgroundColor: Colors.white,
          shadowColor: Colors.red,
          elevation: 2,
          leading: Icon(
            Icons.error,
            color: Colors.red,
          ),
          content: Text("Something went wrong"),
          actions: [
            Icon(
              Icons.close,
            ),
          ],
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      });
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }
}
