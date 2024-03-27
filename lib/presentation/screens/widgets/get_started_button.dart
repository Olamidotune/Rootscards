import 'package:flutter/material.dart';

class GetStartedButton extends StatelessWidget {
  final Function()? onTap;
  const GetStartedButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: GestureDetector(
        onTap: onTap,
        child: Image.asset("assets/images/getstarted_button.png"),
      ),
    );
  }
}
