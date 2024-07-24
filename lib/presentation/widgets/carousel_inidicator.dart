// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rootscards/config/colors.dart';

class CarouselIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final double activeIndicatorLength;
  final Color activeIndicatorColor;
  final Color inactiveIndicatorColor;

  CarouselIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.activeIndicatorLength = 20,
    this.activeIndicatorColor = BLACK,
    this.inactiveIndicatorColor = const Color(0xFFDCDADE),
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> indicators = [];

    for (var i = 1; i <= count; i++) {
      indicators.add(
        Container(
          width: currentIndex == i - 1 ? activeIndicatorLength : 10,
          height: 10.h,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                currentIndex == i - 1
                    ? activeIndicatorColor
                    : inactiveIndicatorColor,
              ),
            ),
            onPressed: null,
            child: Container(),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }
}
