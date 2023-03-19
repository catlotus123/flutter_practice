import 'package:flutter_practice/common/lang/translation_service.dart';
import 'package:flutter_practice/common/provider/app.dart';
import 'package:flutter_practice/common/router/app_pages.dart';
import 'package:flutter_practice/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Global.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider<AppState>.value(value: Global.appState)],
    child: Consumer<AppState>(builder: (context, appState, _) {
      // if (appState.isGrayFilter) {
      //   return const ColorFiltered(
      //     colorFilter: ColorFilter.mode(Colors.red, BlendMode.color),
      //     child: MyApp(),
      //   );
      // } else {
      return const MyApp();
      // }
    }),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812 - 44 - 34),
        builder: (context, child) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: AppPages.initialRoute,
              getPages: AppPages.routes,
              unknownRoute: AppPages.unknownRoute,
              locale: TranslationService.locale,
              fallbackLocale: TranslationService.locale,
              translations: TranslationService(),
              theme: ThemeData.light(),
            ));
  }
}
