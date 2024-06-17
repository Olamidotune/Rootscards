import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rootscards/config/colors.dart';

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
        width: MediaQuery.of(context).size.width * .23,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: GREY
          )
        ),
        child: SvgPicture.asset(
          "assets/svg/$iconName.svg",
        ),
      ),
    );
  }
}
