import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/blocs/sign_up/bloc/sign_up_bloc.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/helper/helper_function.dart';
import 'package:rootscards/src/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:rootscards/src/shared/widgets/button.dart';
import 'package:rootscards/src/shared/widgets/custom_snackabar.dart';
import 'package:rootscards/src/shared/widgets/small_social_button.dart';
import 'package:rootscards/src/shared/widgets/custom_text_form_field.dart';

class SecondSignUpScreen extends HookWidget {
  static const String routeName = "sign_up second screen";
  const SecondSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final busy = useState(false);
    final userNameController = useTextEditingController();
    final phoneNumberController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscurePassword = useState(true);
    final checkTerms = useState(false);

    final Future<String> email = getEmail();

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
                    child: InkWell(
                      onTap: () async {
                        final emailValue = await email;
                        debugPrint(emailValue.toString());
                      },
                      child: Text(
                        "Create Account",
                        style: context.textTheme.titleLarge?.copyWith(
                            color: Colors.black,
                            fontSize: 36,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  AppSpacing.verticalSpaceMedium,
                  Form(
                    key: formKey,
                    child: AutofillGroup(
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: userNameController,
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
                          AppSpacing.verticalSpaceSmall,
                          CustomTextField(
                            controller: phoneNumberController,
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
                          AppSpacing.verticalSpaceSmall,
                          CustomTextField(
                            suffixIcon: IconButton(
                              onPressed: () {
                                obscurePassword.value = !obscurePassword.value;
                              },
                              icon: obscurePassword.value
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
                            obscureText: obscurePassword.value,
                            controller: passwordController,
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
                          value: checkTerms.value,
                          onChanged: (bool? checkTerms) {
                            checkTerms = checkTerms!;
                          },
                        ),
                        Text("Accept Terms")
                      ],
                    ),
                  ),
                  AppSpacing.verticalSpaceLarge,
                  BlocListener<SignUpBloc, SignUpState>(
                    listener: (context, state) {
                      if (state is SignUpLoading) {
                        busy.value = true;
                      } else {
                        busy.value = false;
                      }
                      if (state is SignUpSuccess) {
                        CustomSnackbar.show(context, state.message);
                      }
                      if (state is SignUpFailed) {
                        CustomSnackbar.show(context, state.message,
                            isError: true);
                      } else if (state is SignUpError) {
                        CustomSnackbar.show(context, state.error,
                            isError: true);
                      }
                    },
                    child: Button(
                      pill: true,
                      busy: busy.value,
                      "Create Account",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final emailValue = await email;
                          context.read<SignUpBloc>().add(
                                SignUp(
                                  email: emailValue,
                                  password: passwordController.text,
                                  fullName: userNameController.text,
                                  phoneNumber: phoneNumberController.text,
                                  account: "individual",
                                  referer: "referer",
                                ),
                              );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 0.05.sh,
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

 
  Future<String> getEmail() async {
    String email = await HelperFunction.getUserEmailfromSF() ?? '';
    return email;
  }
}
