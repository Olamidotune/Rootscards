import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SmallSocialButton extends StatelessWidget {
  final String iconName;
  final VoidCallback? onPressed;

  const SmallSocialButton({
    super.key,
    required this.iconName,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        // margin: EdgeInsets.all(30.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60.w),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: SvgPicture.asset(
          "assets/svg/$iconName.svg",
          width: 20.w,
          height: 59.h,
        ),
      ),
    );
  }
}
