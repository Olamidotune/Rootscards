// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


const double MIN_SUPPORTED_SCREEN_HEIGHT = 667;
const double MIN_SUPPORTED_SCREEN_WIDTH = 540;

class AppSpacing {
  static double horizontalSpacingHuge = 20.w;
  static double horizontalSpacingMedium = 15.w;
  static double horizontalSpacingSmall= 5.w;

  static Widget verticalSpaceTiny = SizedBox(height: 5.h);
  static Widget verticalSpaceSmall = SizedBox(height: 10.h);
  static Widget verticalSpaceMedium = SizedBox(height: 25.h);
  static Widget verticalSpaceLarge = SizedBox(height: 40.h);
  static Widget verticalSpaceHuge = SizedBox(height: 60.h);

  static Widget horizontalSpaceTiny = SizedBox(width: 5.w);
  static Widget horizontalSpaceSmall = SizedBox(width: 10.w);
  static Widget horizontalSpaceMedium = SizedBox(width: 25.w);
  static Widget horizontalSpaceLarge = SizedBox(width: 40.w);
}
