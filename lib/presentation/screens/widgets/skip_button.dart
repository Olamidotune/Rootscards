import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  final double portView;
  final Function()? onTap;
  const SkipButton({super.key, this.onTap, required this.portView});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
