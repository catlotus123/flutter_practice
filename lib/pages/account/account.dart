import 'package:flutter_practice/common/lang/lang.dart';
import 'package:flutter_practice/common/provider/app.dart';
import 'package:flutter_practice/common/router/app_router.dart';
import 'package:flutter_practice/common/values/values.dart';
import 'package:flutter_practice/common/widgets/app.dart';
import 'package:flutter_practice/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      appBar: transparentAppBar(
        context: context,
        title: Text(
          userCenter.tr,
          style: const TextStyle(color: AppColors.primaryText),
        ),
      ),
      body: Column(
        children: [
          const Divider(),
          Text('${userName.tr}: ${Global.profile?.nickname}'),
          MaterialButton(
            minWidth: 140.w,
            // color: AppColors.secondaryElement,
            onPressed: () {
              Get.updateLocale(const Locale('en', 'US'));
            },
            child: const Text('使用英文'),
          ),
          MaterialButton(
            minWidth: 140.w,
            // color: AppColors.secondaryElement,
            onPressed: () {
              Get.updateLocale(const Locale('zh', 'Hans'));
            },
            child: const Text('使用中文'),
          ),
          MaterialButton(
            minWidth: 140.w,
            // color: ThemeData.,
            onPressed: () {
              Get.changeTheme(Get.isDarkMode
                  ? ThemeData.light(useMaterial3: true)
                  : ThemeData.dark(useMaterial3: true));
            },
            child: const Text('切换主题'),
          ),
          MaterialButton(
            minWidth: 140.w,
            // color: ThemeData.,
            onPressed: () {
              // Provider.of<AppState>(context).switchGrayFilter();
              appState.switchGrayFilter();
            },
            child: Text(
              '是否黑白化 ${appState.isGrayFilter}',
              style: TextStyle(
                  color: appState.isGrayFilter
                      ? AppColors.primaryText
                      : AppColors.secondaryElementText),
            ),
          ),
          MaterialButton(
            minWidth: 140.w,
            // color: AppColors.secondaryElement,
            onPressed: () async {
              await Global.saveProfile(null);
              Get.offAllNamed(AppRoutes.Signin);
            },
            child: const Text('退出登录'),
          ),
        ],
      ),
    );
  }
}
