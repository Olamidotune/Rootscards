import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/presentation/screens/auth/sign_in/sign_in.dart';
import 'package:rootscards/presentation/widgets/big_social_media_button.dart';

class GetStartedScreen extends StatefulWidget {
  static const String routeName = 'get_started_screen';
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final ScrollController _scrollController = ScrollController();

  List<String> list = <String>['English(UK)', 'English(US)'];
  String dropdownValue = "English(UK)";

  @override
  Widget build(BuildContext context) {
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
                    iconSize: 18.h,),
        title: Container(
          height: 30.h,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 15),
                ),
              );
            }).toList(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.info_outline),
            iconSize: 18.h,
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: height,
          child: Padding(
            padding: EdgeInsets.only(
              top: height <= 550 ? 10 : 20,
              left: 20,
              right: 20,
            ),
            child: RawScrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset("assets/svg/logo.svg"),
                    SizedBox(
                      height: height / 20,
                    ),
                    Text(
                      "Create a profile, follow other people's accounts,\n create your space and more.",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium!.copyWith(color: Colors.grey.shade700)
                      // style: TextStyle(color: Colors.grey.shade700),
                    ),
                    SizedBox(
                      height: height / 20,
                    ),
                    SocialMediaButton(
                      title: "Use Email or Phone Number",
                      leading: "sms",
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Text("or"),
                    SizedBox(
                      height: height / 50,
                    ),
                    SocialMediaButton(
                      title: "Continue with Facebook",
                      leading: "facebook",
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                    SocialMediaButton(
                      title: "Continue with Google",
                      leading: "google",
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                    SocialMediaButton(
                      title: "Continue with Apple",
                      leading: "apple",
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "By continuing, you agree to Pipel's ",
                        style: TextStyle(
                            fontFamily: "lato",
                            fontWeight: FontWeight.normal,
                            fontSize: 13.sp,
                            color: Colors.grey.shade700),
                        children: [
                          TextSpan(
                            text: "Terms of Service\n",
                            style: TextStyle(
                                fontFamily: "lato",
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                                color: BLACK),
                          ),
                          TextSpan(
                            text: " and ",
                            style: TextStyle(
                                fontFamily: "lato",
                                fontWeight: FontWeight.normal,
                                fontSize: 13.sp,
                                color: Colors.grey.shade700),
                          ),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                                fontFamily: "lato",
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                                color: BLACK),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.90.h * height <= 700
                          ? .05.h * height
                          : height * .08.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          SignInScreen.routeName,
                        );
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                                fontFamily: "lato",
                                fontWeight: FontWeight.normal,
                                fontSize: 13.sp,
                                color: Colors.grey.shade700),
                            children: [
                              TextSpan(
                                text: "Login",
                                style: TextStyle(
                                    fontFamily: "lato",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                    color: BLACK),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
