// ignore_for_file: sized_box_for_whitespace, use_key_in_widget_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/config/colors.dart';
import 'package:rootscards/extensions/build_context.dart';

class Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Color? textColor;
  final Color? disabledTextColor;
  final Color? color;
  final IconData? icon;
  final Color? iconColor;
  final bool busy;
  final bool pill;

  const Button(this.text,
      {this.onPressed,
      this.color,
      this.icon,
      this.iconColor,
      this.textColor,
      this.disabledTextColor,
      this.busy = false,
      this.pill = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
       height: .08.sh,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed))
              return BUTTONGREEN;
            else if (states.contains(WidgetState.disabled)) return GREY2;
            return BUTTONGREEN;
          }),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(pill ? 60.w : 10.0),
            ),
          )),
        ),
        onPressed: onPressed,
        child: busy
            ? Container(
                width: 20.0.w,
                height: 20.0.h,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : (icon == null
                ? Text(
                    text!,
                    style: context.textTheme.bodyMedium!.copyWith(
                        color:
                            onPressed == null ? textColor : disabledTextColor,
                        fontWeight: FontWeight.bold),
                  )
                : Icon(
                    icon,
                    color: iconColor ?? Colors.black,
                  )),
      ),
    );
  }
}
