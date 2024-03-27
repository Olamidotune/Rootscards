import 'dart:convert';

import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/presentation/screens/auth/sign_in.dart';
import 'package:rootscards/presentation/screens/widgets/button.dart';
import 'package:sizer/sizer.dart';
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
                              resetPassword(_emailController.text),
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
                              resetPassword(_emailController.text);
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
                          height: MediaQuery.of(context).size.height / 2.2,
                        ),
                        const Text(
                          "rootcards.com",
                          style: TextStyle(fontWeight: FontWeight.w600),
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

  Future<void> resetPassword(String email) async {
    if (_busy) return;

    if (!_formKey.currentState!.validate()) return;

    setState(() => _busy = true);

    // Define your API endpoint for password reset
    final url = Uri.parse('https://api.idonland.com/user/forgotPassword');

    // Create a basic authentication string by combining username and password
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('x-api:$email'));

    try {
      // Make a POST request with basic authentication headers
      final response = await http.post(
        url,
        headers: <String, String>{
          'Authorization': basicAuth,
          'Content-Type': 'application/json', // Adjust content type as required
        },
        body: jsonEncode(<String, String>{
          'email':
              email, // Include any additional parameters required by your API
        }),
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        String status = responseData['status'];

        if (status == "200") {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Sucessful \nwe sent next step to your email"),
              duration: Duration(seconds: 5),
            ),
          );
          Navigator.of(context).popAndPushNamed(SignInScreen.routeName);
          print('Password reset successful');
          setState(() => _busy = false);
        }
      } else {
        // Handle error
        print('Password reset failed: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Email does not exist"),
          duration: Duration(seconds: 2),
        ),
      );
      print('Error resetting password: $e');
      setState(() => _busy = false);
    }
  }
}
