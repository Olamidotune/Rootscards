// ignore_for_file: use_build_context_synchronously, prefer_const_constructors
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/presentation/screens/auth/passowrd/forgot_password.dart';
import 'package:rootscards/presentation/screens/widgets/button.dart';
import 'package:rootscards/presentation/screens/widgets/small_social_button.dart';

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
  final FocusNode _passwordFocusNode = FocusNode();

  bool _busy = false;
  bool _obscurePassword = true;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
          title: Text(
            "Login",
            style: TextStyle(
                fontSize: 20, color: BLACK, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.info_outline),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(90.0), // Adjust the height as needed
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15, vertical: height * 0.01),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Welcome Back",
                      style: context.textTheme.headlineLarge!.copyWith(
                          fontFamily: "LoveYaLikeASister", fontSize: 32.sp),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey.shade300),
                    child: TabBar(
                      onTap: (value) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          setState(() {
                            _tabController.index = value;
                          });
                        });
                      },
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: BLACK,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(
                          child: Text(
                            "Email",
                            style: context.textTheme.bodyMedium?.copyWith(
                                color: _tabController.index == 0
                                    ? Colors.white
                                    : BLACK),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Phone number",
                            style: context.textTheme.bodyMedium?.copyWith(
                                color: _tabController.index == 1
                                    ? Colors.white
                                    : BLACK),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            height: height,
            padding: EdgeInsets.only(
              top: height <= 550 ? 10 : 20,
              left: 20,
              right: 20,
            ),
            child: TabBarView(
              children: [
                Container(
                  child: RawScrollbar(
                    controller: _scrollControllerEmail,
                    thumbVisibility: true,
                    radius: Radius.circular(10),
                    thumbColor: GREY,
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
                                      autofillHints: const [
                                        AutofillHints.email
                                      ],
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 10),
                                        hintText: "Email or Username",
                                        hintStyle: const TextStyle(
                                            color: Colors.black26,
                                            fontWeight: FontWeight.bold),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide(color: GREY2),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: BUTTONGREEN),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    AppSpacing.verticalSpaceSmall,
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: _passwordController,
                                      focusNode: _passwordFocusNode,
                                      textInputAction: TextInputAction.go,
                                      obscureText: _obscurePassword,
                                      // onFieldSubmitted: (_) => _signIn(
                                      //     _emailController.text,
                                      //     _passwordController.text,
                                      //     context),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please provide a password.";
                                        }
                                        return null;
                                      },
                                      style: const TextStyle(),
                                      autofillHints: const [
                                        AutofillHints.email
                                      ],
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 10),
                                        suffixIcon: IconButton(
                                            onPressed: () => setState(() =>
                                                _obscurePassword =
                                                    !_obscurePassword),
                                            icon: _obscurePassword
                                                ? const Icon(Icons.visibility)
                                                : const Icon(
                                                    Icons.visibility_off)),
                                        hintText: "Password",
                                        hintStyle: const TextStyle(
                                            color: Colors.black26,
                                            fontWeight: FontWeight.bold),
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30),
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: BUTTONGREEN),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    AppSpacing.verticalSpaceSmall,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Remember me",
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: Colors.black,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => Navigator.of(context)
                                              .pushNamed(ForgotPasswordScreen
                                                  .routeName),
                                          child: Text(
                                            "Forgot password?",
                                            style: context.textTheme.bodyMedium
                                                ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: height * .04),
                                    Button(
                                      busy: _busy,
                                      "Login",
                                      textColor: BLACK,
                                      disabledTextColor: BLACK,
                                      pill: true,
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: height * .04),
                            Text(
                              "Or sign in with",
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(color: GREY),
                            ),
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
                            SizedBox(height: height * .01),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "By continuing, you agree to Pipel's ",
                                style: TextStyle(
                                    fontFamily: "lato",
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13,
                                    color: GREY),
                                children: [
                                  TextSpan(
                                    text: "Terms of Service\n",
                                    style: TextStyle(
                                        fontFamily: "lato",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: BLACK),
                                  ),
                                  TextSpan(
                                    text: " and ",
                                    style: TextStyle(
                                        fontFamily: "lato",
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13,
                                        color: Colors.grey.shade700),
                                  ),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                        fontFamily: "lato",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: BLACK),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0.90 * height <= 700
                                  ? .03 * height
                                  : height * .13,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                      fontFamily: "lato",
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                      color: GREY),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      text: " Create Account",
                                      style: TextStyle(
                                          fontFamily: "lato",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: BLACK),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: RawScrollbar(
                    controller: _scrollControllerPhone,
                    thumbVisibility: true,
                    radius: Radius.circular(10),
                    thumbColor: GREY,
                    child: SingleChildScrollView(
                      controller: _scrollControllerPhone,
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _phoneNumberController,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(
                                  "[a-zA-z0-9]",
                                ),
                              ),
                            ],
                            style: const TextStyle(color: BLACK),
                            autofillHints: const [AutofillHints.email],
                            decoration: InputDecoration(
                              // prefix: Row(
                              //   children: [
                              //     Icon(Icons.flag),
                              //     Text(
                              //       "+234",
                              //       style: TextStyle(color: Colors.black),
                              //     ),
                              //     const VerticalDivider(
                              //       width: 20,
                              //       thickness: 1,
                              //       indent: 20,
                              //       endIndent: 0,
                              //       color: Colors.grey,
                              //     ),
                              //   ],
                              // ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              hintText: "Phone number",
                              hintStyle: const TextStyle(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.bold),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: GREY2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: BUTTONGREEN),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * .06),
                          Button(
                            busy: _busy,
                            "Send Verification Code",
                            textColor: BLACK,
                            disabledTextColor: BLACK,
                            pill: true,
                            onPressed: () {},
                          ),
                          SizedBox(height: height * .04),
                          Text(
                            "Or sign in with",
                            style: context.textTheme.bodyMedium
                                ?.copyWith(color: GREY),
                          ),
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
                          SizedBox(height: height * .01),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "By continuing, you agree to Pipel's ",
                              style: TextStyle(
                                  fontFamily: "lato",
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                  color: GREY),
                              children: [
                                TextSpan(
                                  text: "Terms of Service\n",
                                  style: TextStyle(
                                      fontFamily: "lato",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: BLACK),
                                ),
                                TextSpan(
                                  text: " and ",
                                  style: TextStyle(
                                      fontFamily: "lato",
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                      color: Colors.grey.shade700),
                                ),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                      fontFamily: "lato",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: BLACK),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 0.90 * height <= 700
                                ? .14 * height
                                : height * .23,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(
                                    fontFamily: "lato",
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13,
                                    color: GREY),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                    text: " Create Account",
                                    style: TextStyle(
                                      fontFamily: "lato",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: BLACK,
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
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
}

// import 'dart:async';
// import 'dart:convert';
// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rootscards/config/colors.dart';
// import 'package:rootscards/config/dimensions.dart';
// import 'package:rootscards/extensions/build_context.dart';
// import 'package:rootscards/presentation/screens/auth/device_auth_screen.dart';
// import 'package:rootscards/presentation/screens/auth/forgot_password.dart';
// import 'package:rootscards/presentation/screens/auth/sign_up.dart';
// import 'package:rootscards/presentation/screens/widgets/button.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';

// class SignInScreen extends StatefulWidget {
//   static const String routeName = "sign_in screen";

//   const SignInScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final FocusNode _passwordFocusNode = FocusNode();

//   bool _busy = false;
//   bool _obscurePassword = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
//             alignment: Alignment.center,
//             child: Column(
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Sign In",
//                       style: context.textTheme.titleLarge?.copyWith(
//                         color: Colors.black,
//                         fontSize: 45,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 0.5.h,
//                     ),
//                     RichText(
//                       text: TextSpan(
//                         text: "Have an account already?",
//                         style: const TextStyle(
//                             fontFamily: "McLaren", color: Colors.black),
//                         children: [
//                           TextSpan(
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () => Navigator.of(context)
//                                   .popAndPushNamed(SignUpScreen.routeName),
//                             text: " Sign up",
//                             style: const TextStyle(
//                               color: THEME,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 2.h,
//                     ),
//                     Form(
//                       key: _formKey,
//                       child: AutofillGroup(
//                         child: Column(
//                           children: [
//                             const Align(
//                               alignment: Alignment.topLeft,
//                               child: Text(
//                                 "Email",
//                                 style: TextStyle(
//                                   color: BLACK,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 0.5.h,
//                             ),
//                             TextFormField(
//                               keyboardType: TextInputType.emailAddress,
//                               controller: _emailController,
//                               textInputAction: TextInputAction.next,
//                               validator: (value) {
//                                 if (EmailValidator.validate(
//                                     value?.trim() ?? "")) {
//                                   return null;
//                                 }
//                                 return "Please provide a valid email address";
//                               },
//                               style: const TextStyle(color: BLACK),
//                               autofillHints: const [AutofillHints.email],
//                               decoration: InputDecoration(
//                                 prefixIcon: Image.asset(
//                                     "assets/images/message-icon.png"),
//                                 hintText: "enter your email",
//                                 hintStyle:
//                                     const TextStyle(color: Colors.black26),
//                                 border: const OutlineInputBorder(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(7),
//                                   ),
//                                 ),
//                                 focusedBorder: const OutlineInputBorder(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(
//                                       7,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 1.h,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   "Password",
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                                 GestureDetector(
//                                     onTap: () => Navigator.of(context)
//                                         .pushNamed(
//                                             ForgotPasswordScreen.routeName),
//                                     child: const Text(
//                                       "forgot password?",
//                                       style: TextStyle(fontSize: 12),
//                                     )),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 0.5.h,
//                             ),
//                             TextFormField(
//                               keyboardType: TextInputType.text,
//                               controller: _passwordController,
//                               focusNode: _passwordFocusNode,
//                               textInputAction: TextInputAction.go,
//                               obscureText: _obscurePassword,
//                               onFieldSubmitted: (_) => _signIn(
//                                   _emailController.text,
//                                   _passwordController.text,
//                                   context),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return "Please provide a password.";
//                                 }
//                                 return null;
//                               },
//                               style: const TextStyle(),
//                               autofillHints: const [AutofillHints.email],
//                               decoration: InputDecoration(
//                                 prefixIcon: Image.asset(
//                                     "assets/images/password-icon.png"),
//                                 suffixIcon: IconButton(
//                                     onPressed: () => setState(() =>
//                                         _obscurePassword = !_obscurePassword),
//                                     icon: _obscurePassword
//                                         ? const Icon(Icons.visibility)
//                                         : const Icon(Icons.visibility_off)),
//                                 hintText: "enter your password",
//                                 hintStyle:
//                                     const TextStyle(color: Colors.black26),
//                                 border: const OutlineInputBorder(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(7),
//                                   ),
//                                 ),
//                                 focusedBorder: const OutlineInputBorder(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(
//                                       7,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     SizedBox(
//                       height: 1.5.h,
//                     ),
//                     Button(
//                       busy: _busy,
//                       "login to your account",
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           _signIn(
//                             _emailController.text,
//                             _passwordController.text,
//                             context,
//                           );
//                         }
//                       },
//                     ),
//                     SizedBox(
//                       height: 1.5.h,
//                     ),
//                     Text(
//                       "A creators handy tool..\nShow off all of you, in one link.",
//                       style: TextStyle(fontSize: 12),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height <=
//                               MIN_SUPPORTED_SCREEN_HEIGHT
//                           ? MediaQuery.of(context).size.height * 0.2
//                           : MediaQuery.of(context).size.height * 0.38,
//                     ),
//                     Text(
//                       "rootcards.com",
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _signIn(
//       String email, String password, BuildContext context) async {
//     if (_busy) return;
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _busy = true);

//     String apiUrl = 'https://api.idonland.com/';
//     Map<String, String> requestBody = {
//       'email': email,
//       'password': password,
//     };
//     try {
//       final http.Response response = await http.post(
//         Uri.parse(apiUrl),
//         body: json.encode(requestBody),
//         headers: {'Content-Type': 'application/json'},
//       ).timeout(Duration(seconds: 30));
//       if (response.statusCode == 200) {
//         Map<String, dynamic> responseData = json.decode(response.body);
//         String status = responseData['status'];
//         if (status == "201") {
//           String xpub1 = responseData['data']['xpub1'];
//           String xpub2 = responseData['data']['xpub2'];
//           debugPrint('Sign In Successful: $responseData');
//           debugPrint('Xpub1: $xpub1');
//           debugPrint('Xpub2: $xpub2');
//           debugPrint(email);
//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           await prefs.setString('xpub1', xpub1);
//           await prefs.setString('xpub2', xpub2);
//           ScaffoldMessenger.of(context).showMaterialBanner(
//             MaterialBanner(
//               backgroundColor: Colors.white,
//               shadowColor: Colors.green,
//               elevation: 2,
//               leading: const Icon(
//                 Icons.check,
//                 color: Colors.green,
//               ),
//               content: RichText(
//                 text: const TextSpan(
//                   text: "Successful",
//                   style: TextStyle(
//                       color: BLACK,
//                       fontFamily: "Poppins",
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15),
//                   children: [
//                     TextSpan(
//                       text: "\nWe sent next steps to your email",
//                       style: TextStyle(
//                           fontFamily: "Poppins",
//                           fontWeight: FontWeight.normal,
//                           fontSize: 11),
//                     ),
//                   ],
//                 ),
//               ),
//               actions: const [
//                 Icon(
//                   Icons.close,
//                 ),
//               ],
//             ),
//           );
//           setState(() => _busy = false);
//           Future.delayed(const Duration(seconds: 1), () async {
//             ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
//             Navigator.of(context).pushNamedAndRemoveUntil(
//               SignInAuthScreen.routeName,
//               (_) => false,
//             );
//           });
//         } else {
//           setState(() => _busy = false);
//           debugPrint('Sign Up Failed. Status Code: $responseData');
//           String errorMessage = responseData['data']['message'];
//           ScaffoldMessenger.of(context).showMaterialBanner(
//             MaterialBanner(
//               backgroundColor: Colors.white,
//               shadowColor: Colors.red,
//               elevation: 2,
//               leading: const Icon(
//                 Icons.error,
//                 color: Colors.red,
//               ),
//               content: RichText(
//                 text: TextSpan(
//                   text: "An error occurred",
//                   style: const TextStyle(
//                       color: BLACK,
//                       fontFamily: "Poppins",
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15),
//                   children: [
//                     TextSpan(
//                       text: "\n$errorMessage",
//                       style: const TextStyle(
//                           fontFamily: "Poppins",
//                           fontWeight: FontWeight.normal,
//                           fontSize: 11),
//                     ),
//                   ],
//                 ),
//               ),
//               actions: const [
//                 Icon(
//                   Icons.close,
//                 ),
//               ],
//             ),
//           );
//           Future.delayed(const Duration(seconds: 2), () {
//             ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
//           });
//         }
//       } else {
//         debugPrint('Sign In Failed. Status Code: ${response.statusCode}');
//         debugPrint('Error Message: ${response.body}');
//         setState(() => _busy = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             backgroundColor: Colors.red,
//             content: Text("Email and Password do not match"),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     } catch (e) {
//       setState(() => _busy = false);
//       debugPrint('Something went wrong: $e');
//       ScaffoldMessenger.of(context).showMaterialBanner(
//         MaterialBanner(
//           backgroundColor: Colors.white,
//           shadowColor: Colors.red,
//           elevation: 2,
//           leading: Icon(
//             Icons.error,
//             color: Colors.red,
//           ),
//           content: RichText(
//             text: const TextSpan(
//               text: "Oops!",
//               style: TextStyle(
//                   color: BLACK,
//                   fontFamily: "Poppins",
//                   fontWeight: FontWeight.bold,
//                   fontSize: 15),
//               children: [
//                 TextSpan(
//                   text: "\nCheck your internet connection and try again.",
//                   style: TextStyle(
//                       fontFamily: "Poppins",
//                       fontWeight: FontWeight.normal,
//                       fontSize: 11),
//                 ),
//               ],
//             ),
//           ),
//           actions: const [
//             Icon(
//               Icons.close,
//             ),
//           ],
//         ),
//       );
//       Future.delayed(const Duration(seconds: 2), () {
//         ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
//       });
//     }
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('email', email);
//   }
// }
