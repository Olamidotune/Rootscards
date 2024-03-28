import 'package:flutter/material.dart';

class GetStartedButton extends StatelessWidget {
  final Function()? onTap;
  final bool busy;
  const GetStartedButton({
    super.key,
    this.onTap,
    this.busy = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: GestureDetector(
        onTap: onTap,
        child: busy
            ? Container(
                width: 20.0,
                height: 20.0,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Image.asset("assets/images/getstarted_button.png"),
      ),
    );
  }
}
