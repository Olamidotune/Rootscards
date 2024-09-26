// ignore_for_file: use_build_context_synchronously, prefer_const_constructors
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/blocs/auth/auth_bloc.dart';
import 'package:rootscards/blocs/auth/auth_event.dart';
import 'package:rootscards/blocs/auth/auth_state.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/helper/helper_function.dart';
import 'package:rootscards/src/shared/widgets/custom_text_form_field.dart';
import '../otp.dart';
import '../passowrd/forgot_password.dart';
import '../../space/space_screen.dart';
import 'package:rootscards/src/shared/widgets/button.dart';
import 'package:rootscards/src/shared/widgets/small_social_button.dart';
import 'package:rootscards/services/auth_services.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = "sign_in_screen";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ScrollController _scrollControllerEmail = ScrollController();
  final ScrollController _scrollControllerPhone = ScrollController();

  bool _busy = false;
  bool _obscurePassword = true;
  AuthServices authServices = AuthServices();
  bool isRemembered = false;

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    authServices.getDeviceID();
    _getEmail();
  }

  _getEmail() async {
    _emailController.text = await HelperFunction.getUserEmailfromSF() ?? '';
  }

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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            setState(() => _busy = true);
          } else {
            setState(() => _busy = false);
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is AuthSuccess) {
            if (state.needsDeviceAuth) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Welcome")),
              );
              Navigator.of(context).popAndPushNamed(OtpScreen.routeName);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Welcome Back")),
              );
              Navigator.of(context).popAndPushNamed(SpaceScreen.routeName);
            }
          }
        },
        child: SafeArea(
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
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
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
                      controller: _tabController,
                      dividerColor: Colors.transparent,
                      onTap: (value) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          setState(() {
                            _tabController.index = value;
                          });
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: _tabController.index == 0
                                        ? Colors.white
                                        : Colors.black),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Phone number",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: _tabController.index == 1
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
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      RawScrollbar(
                        controller: _scrollControllerEmail,
                        thumbVisibility: true,
                        radius: Radius.circular(10),
                        thumbColor: Colors.grey,
                        child: SingleChildScrollView(
                          controller: _scrollControllerEmail,
                          physics: BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.horizontalSpacingSmall),
                            child: Column(
                              children: [
                                Form(
                                  key: _formKey,
                                  child: AutofillGroup(
                                    child: Column(
                                      children: [
                                        CustomTextField(
                                          controller: _emailController,
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
                                          controller: _passwordController,
                                          textInputAction: TextInputAction.go,
                                          hintText: "Password",
                                          textInputType: TextInputType.text,
                                          obscureText: _obscurePassword,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _obscurePassword =
                                                    !_obscurePassword;
                                              });
                                            },
                                            icon: _obscurePassword
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
                                                    value: isRemembered,
                                                    onChanged:
                                                        (bool? checkTerms) {},
                                                  ),
                                                  Text("Remember me")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () => Navigator.of(context)
                                                  .pushNamed(
                                                      ForgotPasswordScreen
                                                          .routeName),
                                              child: Text(
                                                "Forgot password?",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        AppSpacing.verticalSpaceMedium,
                                        Button(
                                            busy: _busy,
                                            "Login",
                                            textColor: Colors.black,
                                            disabledTextColor: Colors.black,
                                            pill: true,
                                            onPressed: _busy
                                                ? null
                                                : () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      setState(
                                                          () => _busy = !_busy);
                                                      context
                                                          .read<AuthBloc>()
                                                          .add(LoginRequested(
                                                              _emailController
                                                                  .text,
                                                              _passwordController
                                                                  .text));
                                                    }
                                                  }),
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
                                    text:
                                        "By continuing, you agree to Pipel's ",
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
                      ),
                      RawScrollbar(
                        controller: _scrollControllerPhone,
                        thumbVisibility: true,
                        radius: Radius.circular(10),
                        thumbColor: Colors.grey,
                        child: SingleChildScrollView(
                          controller: _scrollControllerPhone,
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: _phoneNumberController,
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
                                busy: _busy,
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
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
