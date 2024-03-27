// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/presentation/screens/auth/device_auth_screen.dart';
import 'package:rootscards/presentation/screens/auth/sign_in.dart';
import 'package:rootscards/presentation/screens/widgets/button.dart';
import 'package:sizer/sizer.dart';

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
  final TextEditingController _phoneNumberController = TextEditingController();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _obscurePassword = false;
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
                "Signup",
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
                      text: " Signin",
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
                        child: Text("Email"),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      TextFormField(
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
                        height: 1.h,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Fullname"),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: _fullNameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please provide your fullname.";
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) =>
                            _phoneNumberFocusNode.requestFocus(),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-z0-9]")),
                        ],
                        style: const TextStyle(),
                        autofillHints: const [AutofillHints.email],
                        decoration: InputDecoration(
                          prefixIcon:
                              Image.asset("assets/images/user-icon.png"),
                          hintText: "enter your fullname",
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
                        height: 1.h,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Phone Number"),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneNumberController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 11) {
                            return "Please provide a valid phone number.";
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) =>
                            _phoneNumberFocusNode.requestFocus(),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        ],
                        style: const TextStyle(),
                        autofillHints: const [AutofillHints.telephoneNumber],
                        decoration: InputDecoration(
                          prefixIcon:
                              Image.asset("assets/images/phone-icon.png"),
                          hintText: "enter your phone number",
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
                        height: 1.h,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Password"),
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
                        onFieldSubmitted: (_) => _signUp,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please provide a password.";
                          }
                          return null;
                        },
                        style: const TextStyle(),
                        autofillHints: const [AutofillHints.email],
                        decoration: InputDecoration(
                          prefixIcon:
                              Image.asset("assets/images/password-icon.png"),
                          suffixIcon: IconButton(
                              onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword),
                              icon: _obscurePassword
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                          hintText: "enter your password",
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
                        height: 3.5.h,
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
                            setState(() => _busy = !_busy);
                          }
                        },
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      const Text(
                        "By tapping create my account and using \n Rootscards you agree to our Terms of Service & \n Privacy Policy.",
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 12,
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

    Map<String, String> requestBody = {
      'email': email,
      'fullName': fullName,
      'password': password,
      'phoneNumber': phoneNumber,
      'account': account,
      'referer': referer,
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
        setState(() => _busy = false);
        if (status == '200') {
          debugPrint('Sign Up Successful: $responseData');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text("Welcome $email"),
              duration: const Duration(seconds: 2),
            ),
          );
          setState(() => _busy = false);
          Navigator.of(context).pushNamedAndRemoveUntil(SignInAuthScreen.routeName, (_) => false);
        } else {
          // User is not authenticated, handle the error
          debugPrint('Sign Up Failed. Status Code: $status');
          String errorMessage = responseData['data']['message'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(errorMessage),
              duration: const Duration(seconds: 2),
            ),
          );
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Something went wrong"),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() => _busy = false);
    }
  }
}
