import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> toastInfo({
  required String? msg,
  Color backgroundColor = Colors.black,
  Color textColor = Colors.white,
}) async {
  if (msg == null) {
    return true;
  }
  if (msg.isEmpty) {
    return true;
  }
  return await Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 16.sp,
  );
}
