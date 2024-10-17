// ignore_for_file: use_build_context_synchronously
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/blocs/sign_up/bloc/sign_up_bloc.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/src/presentation/screens/auth/sign_up/second_sign_up_screen.dart';
import 'package:rootscards/src/shared/widgets/custom_snackbar.dart';
import 'package:rootscards/src/shared/widgets/custom_text_form_field.dart';
import '../sign_in/sign_in.dart';
import 'package:rootscards/src/shared/widgets/button.dart';
import 'package:rootscards/src/shared/widgets/small_social_button.dart';

class SignUpScreen extends HookWidget {
  const SignUpScreen({super.key});
  static const String routeName = "sign_up screen";

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final busy = useState(false);
    final emailController = useTextEditingController();

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
        body: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is CheckSignUpMailLoading) {
              busy.value = true;
            } else {
              busy.value = false;

              if (state is CheckSignUpMailSuccess) {
                CustomSnackbar.show(context,
                    "Email already exists, login with your existing email and password",
                    isError: true);
                Navigator.of(context).popAndPushNamed(SignInScreen.routeName);
              }
            }
            if (state is CheckSignUpMailFailed) {
              CustomSnackbar.show(context, state.error, isError: true);
              Navigator.of(context).pushNamed(SecondSignUpScreen.routeName);
            } else if (state is CheckSignUpMailError) {
              CustomSnackbar.show(context, state.error, isError: true);
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                            fontSize: 36.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    AppSpacing.verticalSpaceLarge,
                    Form(
                      key: formKey,
                      child: AutofillGroup(
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: emailController,
                              textInputAction: TextInputAction.go,
                              hintText: "Enter your email here",
                              textInputType: TextInputType.emailAddress,
                              validator: (value) {
                                if (EmailValidator.validate(
                                    value?.trim() ?? "")) {
                                  return null;
                                }
                                return "Please provide a valid email address";
                              },
                            ),
                            AppSpacing.verticalSpaceSmall,
                            Button(
                              pill: true,
                              busy: busy.value,
                              "Continue",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  busy.value = true;
                                  context
                                      .read<SignUpBloc>()
                                      .add(CheckSignUpMail(
                                        emailController.value.text,
                                        'password',
                                      ));
                                  debugPrint(
                                      "Email: ${emailController.value.text}");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 0.30.sh,
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
                    AppSpacing.verticalSpaceMedium,
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
          ),
        ));
  }
}
