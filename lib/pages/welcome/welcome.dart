import 'package:flutter_practice/common/router/app_router.dart';
import 'package:flutter_practice/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../common/values/values.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _buildPageHeadTitle(),
            _buildPageHeaderDetail(),
            const Spacer(),
            _buildStartButton(context),
          ],
        ),
      ),
    );
  }
}

// ignore: unused_element
Widget _buildPageHeadTitle() {
  return Container(
    margin: EdgeInsets.only(top: 104.w),
    child: Text(
      'Features',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.primaryText,
        fontFamily: 'Montserrat',
        fontSize: 24.sp,
        height: 1,
      ),
    ),
  );
}

// ignore: unused_element
Widget _buildPageHeaderDetail() {
  return Container(
    width: 242.w,
    height: 70.h,
    margin: EdgeInsets.only(top: 14.h),
    child: Text(
      'The best of news channels all in one place. Trusted sources and personalized news for you.',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.primaryText,
        fontFamily: 'Avenir',
        fontWeight: FontWeight.normal,
        fontSize: 16.sp,
        height: 1.3,
      ),
    ),
  );
}

Widget _buildStartButton(BuildContext context) {
  return Container(
    width: 295.w,
    height: 44.h,
    margin: EdgeInsets.only(bottom: 20.h),
    child: MaterialButton(
      onPressed: () {
        Get.toNamed(
            Global.isOfflineLogin ? AppRoutes.Account : AppRoutes.Signin);
      },
      color: AppColors.primaryElement,
      textColor: AppColors.primaryElementText,
      shape: const RoundedRectangleBorder(borderRadius: Radii.k6pxRadius),
      child: const Text('Get started'),
    ),
  );
}
