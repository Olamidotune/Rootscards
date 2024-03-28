// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:rootscards/config/colors.dart';



class Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Color textColor;
  final Color disabledTextColor;
  final Color? color;
  final IconData? icon;
  final Color? iconColor;
  final bool busy;
  final bool pill;

  Button(this.text,
      {this.onPressed,
      this.color,
      this.icon,
      this.iconColor,
      this.textColor = Colors.white,
      this.disabledTextColor = Colors.white,
      this.busy = false,
      this.pill = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52.0,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return GREY;
            else if (states.contains(MaterialState.disabled)) return BLACK;
            return BLACK;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(this.pill ? 40 : 10.0),
            ),
          )),
        ),
        onPressed: onPressed,
        child: busy
            ? Container(
                width: 20.0,
                height: 20.0,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : (icon == null
                ? Text(
                    text!,
                    style: TextStyle(
                        color:
                            onPressed == null ? textColor : disabledTextColor,
                        fontSize: 14.0,
                        fontFamily: "HelveticaRounded"),
                  )
                : Icon(
                    icon,
                    color: iconColor != null ? iconColor : Colors.black,
                  )),
      ),
    );
  }
}
