import 'package:flutter_practice/common/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget btnFlatButtonWidget({
  required VoidCallback onPressed,
  double width = 140,
  double height = 44,
  Color gbColor = AppColors.primaryElement,
  String title = 'button',
  Color fontColor = AppColors.primaryElementText,
  double fontSize = 18,
  String fontName = 'Montserrat',
  FontWeight fontWeight = FontWeight.w400,
}) {
  return SizedBox(
    width: width.w,
    height: height.h,
    child: MaterialButton(
      onPressed: onPressed,
      color: gbColor,
      shape: const RoundedRectangleBorder(borderRadius: Radii.k6pxRadius),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fontColor,
          fontFamily: fontName,
          fontWeight: fontWeight,
          fontSize: fontSize.sp,
          height: 1,
        ),
      ),
    ),
  );
}
