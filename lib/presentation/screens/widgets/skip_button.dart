import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkipButton extends StatelessWidget {
  final double portView;
  final Function()? onTap;
  const SkipButton({super.key, this.onTap, required this.portView});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 10.h),
      child: GestureDetector(
        onTap: onTap,
        child: Image.asset(
          "assets/images/skip_button.png",
          width: portView ,
        ),
      ),
    );
  }
}
