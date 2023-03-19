import 'dart:io';

import 'package:flutter_practice/common/provider/app.dart';
import 'package:flutter_practice/common/router/app_pages.dart';
import 'package:flutter_practice/common/utils/http.dart';
import 'package:flutter_practice/common/utils/storage.dart';
import 'package:flutter_practice/common/values/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_practice/common/entity/entitys.dart';

class Global {
  static LoginInfo? profile = LoginInfo();

  static String channel = '';

  /// 是否第一次打开
  static bool isFirstOpen = false;

  /// 是否离线登录
  static bool isOfflineLogin = false;

  static bool get isRelease => const bool.fromEnvironment('dart.vm.product');

  /// 应用状态,
  static AppState appState = AppState();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await ScreenUtil.ensureScreenSize();

    await StorageUtil().init();
    HttpUtil();

    isFirstOpen = !StorageUtil().getBool(STORAGE_DEVICE_ALREADY_OPEN_KEY);
    if (isFirstOpen) {
      StorageUtil().setBool(STORAGE_DEVICE_ALREADY_OPEN_KEY, true);
    }

    // // 读取离线用户信息
    var profileJson = StorageUtil().getJson(STORAGE_USER_PROFILE_KEY);
    if (profileJson != null) {
      profile = LoginInfo.fromJson(profileJson);
      isOfflineLogin = true;
    }
    AppPages.init();

    // android 状态栏为透明的沉浸
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  // 持久化 用户信息
  static Future<bool> saveProfile(LoginInfo? loginInfo) {
    profile = loginInfo;
    isOfflineLogin = profile != null;
    return StorageUtil().setJson(STORAGE_USER_PROFILE_KEY, loginInfo?.toJson());
  }
}
