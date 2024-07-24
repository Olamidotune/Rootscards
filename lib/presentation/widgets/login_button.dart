import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/config/colors.dart';

class LoginButton extends StatelessWidget {
  final Function()? onTap;
  final Color? textColor;
  final Color? disabledTextColor;

  final IconData? icon;

  const LoginButton(
      {super.key,
      this.onTap,
      this.textColor,
      this.disabledTextColor,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: BLACK,
          ),
        ),
        child: Center(
          child: Text(
            "Login",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
