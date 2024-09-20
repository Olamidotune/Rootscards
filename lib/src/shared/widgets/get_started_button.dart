import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/config/colors.dart';

class GetStartedButton extends StatelessWidget {
  final Function()? onTap;
  final Color? textColor;
  final Color? disabledTextColor;
  final bool? busy;
  final IconData? icon;
  const GetStartedButton({
    super.key,
    this.onTap,
    this.busy = false,
    this.textColor,
    this.disabledTextColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
          height: .08.sh,
        decoration: BoxDecoration(
          color: BLACK,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: BLACK),
        ),
        child: Center(
          child: Text(
            "Get Started",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
