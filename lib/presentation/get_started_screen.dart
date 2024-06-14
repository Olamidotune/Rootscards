import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/presentation/screens/widgets/socail_media_button.dart';

class GetStartedScreen extends StatelessWidget {
  static const String routeName = 'get_started_screen';
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Text("PUT LANGUAGE HERE"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.info_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: height,
          child: Padding(
            padding:  EdgeInsets.only(
             top:  height <= 550 ? 10  : 20,
              left: 20,
              right: 20,
            ),
            child: SingleChildScrollView(
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
                    style: TextStyle(color: Colors.grey.shade700),
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
                          fontSize: 13,
                          color: Colors.grey.shade700),
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
                  height: 0.90 * height <= 700 ? .05 * height : height * .13 ,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(
                            fontFamily: "lato",
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                            color: Colors.grey.shade700),
                        children: [
                          TextSpan(
                            text: "Login",
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
    );
  }
}
