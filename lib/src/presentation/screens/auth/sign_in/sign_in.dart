// ignore_for_file: use_build_context_synchronously, prefer_const_constructors
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/blocs/auth/auth_bloc.dart';
import 'package:rootscards/blocs/auth/auth_event.dart';
import 'package:rootscards/blocs/auth/auth_state.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/helper/helper_function.dart';
import 'package:rootscards/src/presentation/screens/auth/otp.dart';
import 'package:rootscards/src/presentation/screens/auth/password/forgot_password.dart';
import 'package:rootscards/src/presentation/screens/auth/sign_up/sign_up.dart';
import 'package:rootscards/src/presentation/screens/space/space_screen.dart';
import 'package:rootscards/src/shared/widgets/custom_snackbar.dart';
import 'package:rootscards/src/shared/widgets/custom_text_form_field.dart';
import 'package:rootscards/src/shared/widgets/button.dart';
import 'package:rootscards/src/shared/widgets/small_social_button.dart';

class SignInScreen extends HookWidget {
  static const String routeName = "sign_in_screen";
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final scrollControllerEmail = useScrollController();
    final scrollControllerPhone = useScrollController();
    final tabController = useTabController(initialLength: 2);
    final busy = useState(false);
    final obscurePassword = useState(true);
    final isRemembered = useState(false);
    final currentIndex = useState(0);
    final phoneNumberController = useTextEditingController();

    Future<void> getEmail() async {
      String email = await HelperFunction.getUserEmailfromSF() ?? '';
      emailController.text = email;
    }

    useEffect(() {
      void listener() {
        currentIndex.value = tabController.index;
      }
      tabController.addListener(listener);
      getEmail();
      return () => tabController.removeListener(listener);
    }, [tabController]);

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
            "Login",
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
        child: Container(
          height: height,
          padding: EdgeInsets.only(
            top: .6.sp,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 5.w, vertical: .002.sh),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Welcome Back",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontFamily: "LoveYaLikeASister", fontSize: 32.sp),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              AppSpacing.verticalSpaceMedium,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.w),
                      color: Colors.grey.shade200),
                  child: TabBar(
                    controller: tabController,
                    dividerColor: Colors.transparent,
                    onTap: (value) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        tabController.animateTo(value);
                      });
                    },
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.w),
                      color: Colors.black,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(
                        child: Text(
                          "Email",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: tabController.index == 0
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Phone number",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: tabController.index == 1
                                      ? Colors.white
                                      : Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.verticalSpaceMedium,
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    RawScrollbar(
                      controller: scrollControllerEmail,
                      thumbVisibility: true,
                      radius: Radius.circular(10),
                      thumbColor: Colors.grey,
                      child: SingleChildScrollView(
                        controller: scrollControllerEmail,
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.horizontalSpacingSmall),
                          child: Column(
                            children: [
                              Form(
                                key: formKey,
                                child: AutofillGroup(
                                  child: Column(
                                    children: [
                                      CustomTextField(
                                        height: .1,
                                        controller: emailController,
                                        hintText: "Email or Username",
                                        validator: (value) {
                                          if (EmailValidator.validate(
                                              value?.trim() ?? "")) {
                                            return null;
                                          }
                                          return "Please provide a valid email address";
                                        },
                                        textInputAction: TextInputAction.next,
                                        textInputType:
                                            TextInputType.emailAddress,
                                      ),
                                      AppSpacing.verticalSpaceSmall,
                                      CustomTextField(
                                        controller: passwordController,
                                        textInputAction: TextInputAction.go,
                                        hintText: "Password",
                                        textInputType: TextInputType.text,
                                        obscureText: obscurePassword.value,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Password cannot be empty";
                                          }
                                          if (value.length < 6) {
                                            return "Password must be at least 6 characters";
                                          }
                                          return null;
                                        },
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            obscurePassword.value =
                                                !obscurePassword.value;
                                          },
                                          icon: obscurePassword.value
                                              ? Icon(Icons.visibility)
                                              : Icon(
                                                  Icons.visibility_off,
                                                ),
                                        ),
                                      ),
                                      AppSpacing.verticalSpaceSmall,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                Checkbox(
                                                  value: isRemembered.value,
                                                  checkColor: BLACK,
                                                  activeColor: BUTTONGREEN,
                                                  onChanged:
                                                      (bool? checkTerms) {
                                                    isRemembered.value =
                                                        !isRemembered.value;
                                                  },
                                                ),
                                                Text("Remember me")
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => Navigator.of(context)
                                                .pushNamed(ForgotPasswordScreen
                                                    .routeName),
                                            child: Text(
                                              "Forgot password?",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      AppSpacing.verticalSpaceMedium,
                                      BlocConsumer<AuthBloc, AuthState>(
                                        listener: (context, state) {
                                          if (state is AuthLoading) {
                                            busy.value = true;
                                          } else {
                                            busy.value = false;
                                            if (state is AuthSuccess) {
                                              if (state.needsDeviceAuth) {
                                                CustomSnackbar.show(context,
                                                    "Welcome, Please verify your device",
                                                    isError: true);
                                                Navigator.of(context)
                                                    .popAndPushNamed(
                                                        OtpScreen.routeName);
                                              } else {
                                                CustomSnackbar.show(
                                                    context, "Login successful",
                                                    isError: false);
                                                Navigator.of(context)
                                                    .popAndPushNamed(
                                                        SpaceScreen.routeName);
                                              }
                                            } else if (state is AuthFailure) {
                                              CustomSnackbar.show(
                                                  context, state.message,
                                                  isError: true);
                                            } else if (state is AuthError) {
                                              CustomSnackbar.show(
                                                  context, state.error,
                                                  isError: true);
                                            }
                                          }
                                        },
                                        builder: (context, state) {
                                          return Button(
                                              busy: busy.value,
                                              "Login",
                                              textColor: Colors.black,
                                              disabledTextColor: Colors.black,
                                              pill: true,
                                              onPressed: busy.value
                                                  ? null
                                                  : () {
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        busy.value =
                                                            !busy.value;

                                                        context
                                                            .read<AuthBloc>()
                                                            .add(LoginRequested(
                                                                emailController
                                                                    .value.text,
                                                                passwordController
                                                                    .value
                                                                    .text));
                                                      }
                                                    });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AppSpacing.verticalSpaceLarge,
                              Text(
                                "Or sign in with",
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
                              // SizedBox(
                              //   height: 0.90 * height <= 700
                              //       ? .03.h * height
                              //       : height * .19.h,
                              // ),
                              AppSpacing.verticalSpaceLarge,
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: "Don't have an account? ",
                                    style: TextStyle(
                                        fontFamily: "lato",
                                        fontSize: 13.sp,
                                        color: Colors.grey),
                                    children: [
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context).pushNamed(
                                                SignUpScreen.routeName);
                                          },
                                        text: " Create Account",
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
                    RawScrollbar(
                      controller: scrollControllerPhone,
                      thumbVisibility: true,
                      radius: Radius.circular(10),
                      thumbColor: Colors.grey,
                      child: SingleChildScrollView(
                        controller: scrollControllerPhone,
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: phoneNumberController,
                              textInputAction: TextInputAction.go,
                              hintText: 'Phone number',
                              textInputType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(
                                    "[a-zA-z0-9]",
                                  ),
                                ),
                              ],
                            ),
                            AppSpacing.verticalSpaceMedium,
                            Button(
                              busy: busy.value,
                              "Send Verification Code",
                              textColor: Colors.black,
                              disabledTextColor: Colors.black,
                              pill: true,
                              onPressed: () {},
                            ),
                            AppSpacing.verticalSpaceLarge,
                            Text(
                              "Or sign in with",
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
                                Expanded(
                                  child: SmallSocialButton(
                                    iconName: "google",
                                    onPressed: () {},
                                  ),
                                ),
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
                            SizedBox(
                              height: .18.sh,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                      fontFamily: "lato",
                                      fontSize: 13.sp,
                                      color: Colors.grey),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      text: " Create Account",
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
