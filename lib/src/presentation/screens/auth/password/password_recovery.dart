import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/src/shared/widgets/button.dart';
import 'package:rootscards/src/shared/widgets/custom_text_form_field.dart';

class PasswordRecovery extends StatefulWidget {
  static const String routeName = "password_recovery_screen";
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final FocusNode _passwordFocusNode1 = FocusNode();
  final FocusNode _passwordFocusNode2 = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword1 = false;
  bool _obscurePassword2 = false;
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
            onPressed: () {
              Navigator.pop(context);
            },
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
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                        "Password Recovery",
                        style: context.textTheme.headlineLarge!.copyWith(
                            fontFamily: "LoveYaLikeASister", fontSize: 32.sp),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      AppSpacing.verticalSpaceSmall,
                      Text(
                        "For security reasons, enter a new password that is different from the previous one.",
                        style:
                            context.textTheme.bodyMedium!.copyWith(color: GREY),
                      ),
                      AppSpacing.verticalSpaceMedium,
                      CustomTextField(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword1
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: BLACK,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword1 = !_obscurePassword1;
                            });
                          },
                        ),
                        hintText: 'Password',
                        textInputType: TextInputType.text,
                        controller: _passwordController1,
                        focusNode: _passwordFocusNode1,
                        textInputAction: TextInputAction.go,
                        obscureText: _obscurePassword1,
                        inputFormatters: [],
                        autoCorrect: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please provide a password.";
                          }
                          return null;
                        },
                      ),
                      AppSpacing.verticalSpaceSmall,
                      CustomTextField(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: BLACK,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword2 = !_obscurePassword2;
                            });
                          },
                        ),
                        hintText: 'Confirm Password',
                        textInputType: TextInputType.text,
                        controller: _passwordController2,
                        focusNode: _passwordFocusNode2,
                        textInputAction: TextInputAction.go,
                        obscureText: _obscurePassword2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please provide a password.";
                          }
                          if (_passwordController2 != _passwordController1) {
                            return "Password don't match";
                          }
                          return null;
                        },
                      ),
                     SizedBox(height: MediaQuery.of(context).size.height < 600 ? 20 : .5.sh),
                      Button(
                        busy: _busy,
                        "Send",
                        textColor: BLACK,
                        disabledTextColor: BLACK,
                        pill: true,
                        onPressed: () {
                          // Navigator.of(context)
                          //     .popAndPushNamed(OtpScreen.routeName);
                        },
                      )
                    ],
                  )),
            ),
          ),
        ));
  }
}
