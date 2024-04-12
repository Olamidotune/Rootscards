import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NextButton extends StatelessWidget {
  final Function()? onTap;
  const NextButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal:30.0),
      child: GestureDetector(
        onTap: onTap,
          // child: Image.asset("assets/images/next_button.png"),
          child: SvgPicture.asset("assets/svgs/next_button.svg"),
      ),
    );
  }
}