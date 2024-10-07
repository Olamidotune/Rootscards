// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/src/shared/widgets/custom_text_form_field.dart';
import 'password_recovery.dart';
import '../sign_in/sign_in.dart';
import 'package:rootscards/src/shared/widgets/button.dart';
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
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
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
            "Forgot Password",
            style: context.textTheme.bodyMedium?.copyWith(
              color: BLACK,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.info_outline),
            ),
          ],
        ),
        body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordLoadingState) {
              setState(() => _busy = true);
            } else {
              setState(() => _busy = false);
            }
            if (state is ForgotPasswordErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
            if (state is ForgotPasswordFailedState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state is ForgotPasswordSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.of(context).popAndPushNamed(PasswordRecovery.routeName);
            }
          },
          child: SafeArea(
            child: Container(
              height: height,
              padding: EdgeInsets.only(
                top: .01.sh,
                left: 20,
                right: 20,
              ),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reset Your Password",
                        style: context.textTheme.headlineLarge!.copyWith(
                            fontFamily: "LoveYaLikeASister", fontSize: 32.sp),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      AppSpacing.verticalSpaceSmall,
                      Text(
                        "Enter your email and reset your account password to access your personal account again.",
                        style:
                            context.textTheme.bodyMedium!.copyWith(color: GREY),
                      ),
                      AppSpacing.verticalSpaceMedium,
                      CustomTextField(
                        hintText: "Email or Username",
                        textInputType: TextInputType.emailAddress,
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (EmailValidator.validate(value?.trim() ?? "")) {
                            return null;
                          }
                          return "Please provide a valid email address";
                        },
                        onFieldSubmitted: (_) => {
                          if (_formKey.currentState!.validate())
                            {
                              setState(() => _busy = !_busy),
                              context
                                  .read<ForgotPasswordBloc>()
                                  .add(ForgotPasswordEmailEvent(
                                    email: _emailController.text,
                                  ))
                            }
                        },
                      ),
                      AppSpacing.verticalSpaceMedium,
                      Button(
                          busy: _busy,
                          "Send",
                          textColor: BLACK,
                          disabledTextColor: BLACK,
                          pill: true,
                          onPressed: _busy
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => _busy = !_busy);
                                    context.read<ForgotPasswordBloc>().add(
                                        ForgotPasswordEmailEvent(
                                            email:
                                                _emailController.text.trim()));
                                  }
                                })
                    ],
                  )),
            ),
          ),
        ));
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
      final response = await http
          .post(
            url,
            headers: <String, String>{
              'Authorization': basicAuth,
              'Content-Type': 'application/json',
            },
            body: jsonEncode(<String, String>{
              'email': email,
            }),
          )
          .timeout(const Duration(seconds: 30));

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
