// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:rootscards/presentation/screens/widgets/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = "forgot_password_screen";
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// ignore: prefer_final_fields
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password",
                  style: context.textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontSize: 45,
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                const Text(
                  "Forgot  your password?  we've got you.\nYou can always recover your account.",
                  style: TextStyle(),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Form(
                  key: _formKey,
                  child: AutofillGroup(
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text("Enter your registered email"),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        TextFormField(
                          onFieldSubmitted: (_) =>
                              _resetPassword(_emailController.text),
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (EmailValidator.validate(value?.trim() ?? "")) {
                              return null;
                            }
                            return "Please provide a valid email address";
                          },
                          style: const TextStyle(),
                          autofillHints: const [AutofillHints.email],
                          decoration: InputDecoration(
                            prefixIcon:
                                Image.asset("assets/images/message-icon.png"),
                            hintText: "enter your email",
                            hintStyle: const TextStyle(color: Colors.black26),
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
                          height: 1.5.h,
                        ),
                        Button(
                          busy: _busy,
                          "Reset Password",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _resetPassword(_emailController.text);
                            }
                          },
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        const Text(
                          "A creators handy tool..\nShow off all of you, in one link.",
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height <=
                                  MIN_SUPPORTED_SCREEN_HEIGHT
                              ? MediaQuery.of(context).size.height * 0.35
                              : MediaQuery.of(context).size.height * 0.45,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .popAndPushNamed(SignInScreen.routeName);
                          },
                          child: const Text(
                            "go home",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _resetPassword(String email) async {
    if (_busy) return;

    if (!_formKey.currentState!.validate()) return;

    setState(() => _busy = true);

    // Define your API endpoint for password reset
    final url = Uri.parse('https://api.idonland.com/user/forgotPassword');

    // Create a basic authentication string by combining username and password
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('x-api:$email'))}';

    try {
      // Make a POST request with basic authentication headers
      final response = await http.post(
        url,
        headers: <String, String>{
          'Authorization': basicAuth,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        String status = responseData['status'];

        if (status == "200") {
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
          Future.delayed(const Duration(seconds: 1), () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            Navigator.of(context).popAndPushNamed(SignInScreen.routeName);
          });
          debugPrint('Password reset successful');
          setState(() => _busy = false);
        } 
      }
    } catch (e) {
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
                  text: "\nAn error occured",
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
      Future.delayed(const Duration(seconds: 3), () {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      });
      debugPrint('Error resetting password: $e');
      setState(() => _busy = false);
    }
  }
}
