import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class SkipButton extends StatelessWidget {
  final Function()? onTap;
  const SkipButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal:30.0),
      child: GestureDetector(
        onTap: onTap,
          child: Image.asset("assets/images/skip_button.png",
          width: 15.w,
          ),
      ),
    );
  }
}




