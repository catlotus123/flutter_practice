import 'dart:ui';

import 'package:flutter_practice/common/lang/en_US.dart';
import 'package:flutter_practice/common/lang/zh_Hans.dart';
import 'package:get/route_manager.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'zh_Hans': zh_Hans,
      };
}
