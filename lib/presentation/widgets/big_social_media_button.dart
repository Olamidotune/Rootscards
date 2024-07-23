import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rootscards/config/colors.dart';

class SocialMediaButton extends StatelessWidget {
  final String? leading;
  final String? title;
  final VoidCallback? onPressed;

  const SocialMediaButton({
    super.key,
    this.leading,
    this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: ListTile(
          leading: SvgPicture.asset("assets/svg/$leading.svg"),
          title: Text(
            title ?? "",
            textAlign: TextAlign.center,
          ),
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14.sp, color: BLACK),
          onTap: onPressed,
        ));
  }
}
