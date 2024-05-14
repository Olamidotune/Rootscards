import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GetStartedButton extends StatelessWidget {
  final Function()? onTap;
  final Color? textColor;
  final Color? disabledTextColor;
  final bool busy;
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: GestureDetector(
        onTap: onTap,
        child: busy
            ? SizedBox(
                width: 20.0,
                height: 20.0,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : Image.asset(
                "assets/images/getstarted_button.png",
                width: 43.w,
              ),
      ),
    );
  }
}
