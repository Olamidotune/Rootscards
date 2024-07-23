import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/config/colors.dart';

void showSnackBar(context, color, title, subTitle, icon) {
  ScaffoldMessenger.of(context).showMaterialBanner(
   MaterialBanner(
          backgroundColor: Colors.white,
          shadowColor: color,
          elevation: 2,
          leading: Icon(
           icon,
            color: color,
          ),
          content: RichText(
            text:  TextSpan(
              text: title,
              style: TextStyle(
                  color: BLACK,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp),
              children: [
                TextSpan(
                  text: subTitle,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.normal,
                      fontSize: 11.sp),
                ),
              ],
            ),
          ),
          actions: const [
            Icon(
              Icons.close,
            ),
          ],
        ),
  );
}


   