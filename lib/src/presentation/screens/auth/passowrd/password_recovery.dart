import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/config/dimensions.dart';
import 'package:rootscards/extensions/build_context.dart';
import 'package:rootscards/src/shared/widgets/button.dart';

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
  bool _obscurePassword1 = true;
  bool _obscurePassword2 = true;
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
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _passwordController1,
                        focusNode: _passwordFocusNode1,
                        textInputAction: TextInputAction.go,
                        obscureText: _obscurePassword1,
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
                        style: context.textTheme.bodySmall!.copyWith(
                          color: BLACK,
                        ),
                        autofillHints: const [AutofillHints.email],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: .035.sh, horizontal: 25.w),
                          suffixIcon: IconButton(
                              onPressed: () => setState(
                                  () => _obscurePassword1 = !_obscurePassword1),
                              icon: _obscurePassword1
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                          hintText: "Password",
                          hintStyle: const TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.bold),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(60),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: BUTTONGREEN),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                60,
                              ),
                            ),
                          ),
                        ),
                      ),
                      AppSpacing.verticalSpaceSmall,
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _passwordController2,
                        focusNode: _passwordFocusNode2,
                        textInputAction: TextInputAction.go,
                        obscureText: _obscurePassword2,
                        // onFieldSubmitted: (_) => _signIn(
                        //     _emailController.text,
                        //     _passwordController.text,
                        //     context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please provide a password.";
                          }
                          if (_passwordController2 != _passwordController1) {
                            return "Password don't match";
                          }
                          return null;
                        },
                        style: context.textTheme.bodySmall!.copyWith(
                          color: BLACK,
                        ),
                        autofillHints: const [AutofillHints.email],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: .035.sh, horizontal: 25.w),
                          suffixIcon: IconButton(
                              onPressed: () => setState(
                                  () => _obscurePassword2 = !_obscurePassword2),
                              icon: _obscurePassword2
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                          hintText: "Confirm Password",
                          hintStyle: const TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.bold),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(60),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: BUTTONGREEN),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                60,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                      height: .4.sh,
                      ),
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
