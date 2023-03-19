import 'package:flutter_practice/common/router/app_router.dart';
import 'package:flutter_practice/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteAuthMiddleware extends GetMiddleware {
  RouteAuthMiddleware({priority});

  @override
  RouteSettings? redirect(String? route) {
    if (Global.isOfflineLogin) {
      return null;
    }
    Future.delayed(
        const Duration(seconds: 1), () => Get.snackbar('提示', '请先登陆'));
    return const RouteSettings(name: AppRoutes.Signin);
  }
}
