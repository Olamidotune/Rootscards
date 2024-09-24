import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/src/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:rootscards/src/shared/widgets/button.dart';
import 'package:rootscards/src/shared/widgets/small_social_button.dart';
import 'package:rootscards/src/shared/widgets/text_field.dart';

class SecondSignUpScreen extends StatefulWidget {
  static const String routeName = "sign_up second screen";
  const SecondSignUpScreen({super.key});

  @override
  State<SecondSignUpScreen> createState() => _SecondSignUpScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _userNameController = TextEditingController();
final TextEditingController _phoneNumberController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

bool _busy = false;
bool _obscureText = true;
bool checkTerms = false;

class _SecondSignUpScreenState extends State<SecondSignUpScreen> {
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
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  AppSpacing.verticalSpaceLarge,
                  Form(
                    key: _formKey,
                    child: AutofillGroup(
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _userNameController,
                            textInputAction: TextInputAction.next,
                            hintText: "Username",
                            textInputType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please provide a Username";
                              }
                              return null;
                            },
                          ),
                          AppSpacing.verticalSpaceMedium,
                          CustomTextField(
                            controller: _phoneNumberController,
                            textInputAction: TextInputAction.next,
                            hintText: "Phone Number",
                            textInputType: TextInputType.phone,
                            maxLength: 11,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 11) {
                                return "Please provide a valid phone number";
                              }
                              return null;
                            },
                          ),
                          AppSpacing.verticalSpaceMedium,
                          CustomTextField(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: _obscureText
                                  ? Icon(Icons.visibility)
                                  : Icon(
                                      Icons.visibility_off,
                                    ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please provide a password";
                              }
                              if (value.length < 6) {
                                return "Password cannot be less than 6 characters";
                              }
                              return null;
                            },
                            obscureText: _obscureText,
                            controller: _passwordController,
                            textInputAction: TextInputAction.go,
                            hintText: "Password",
                            textInputType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpacing.verticalSpaceTiny,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Checkbox(
                          value: checkTerms,
                          onChanged: (bool? checkTerms) {},
                        ),
                        Text("Accept Terms")
                      ],
                    ),
                  ),
                  AppSpacing.verticalSpaceLarge,
                  Button(
                    pill: true,
                    busy: _busy,
                    "Create Account",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context)
                            .popAndPushNamed(SignInScreen.routeName);
                      }
                    },
                  ),
                  SizedBox(
                    height: 0.1.sh,
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

  @override
  void dispose() {
    _userNameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
