import 'package:flutter_practice/common/middleware/router_auth.dart';
import 'package:flutter_practice/common/router/app_router.dart';
import 'package:flutter_practice/global.dart';
import 'package:flutter_practice/pages/account/account.dart';
import 'package:flutter_practice/pages/notfound/index.dart';
import 'package:flutter_practice/pages/sign_in/bindings.dart';
import 'package:flutter_practice/pages/sign_in/sign_in.dart';
import 'package:flutter_practice/pages/sign_up/bindings.dart';
import 'package:flutter_practice/pages/sign_up/sign_up.dart';
import 'package:flutter_practice/pages/welcome/welcome.dart';
import 'package:get/route_manager.dart';
// ignore_for_file: constant_identifier_names

class AppPages {
  static String initialRoute = AppRoutes.Welcome;
  static init() {
    initialRoute = Global.isFirstOpen == true
        ? AppRoutes.Welcome
        : Global.isOfflineLogin == true
            ? AppRoutes.Account
            : AppRoutes.Signin;
  }

  static final routes = [
    GetPage(name: AppRoutes.Welcome, page: () => const WelcomePage()),
    GetPage(
      name: AppRoutes.Signin,
      page: () => const SignInPage(),
      children: [
        GetPage(
          name: AppRoutes.Signup,
          page: () => const SignUpPage(),
          binding: SignUpLazyPutBinding(),
        ),
      ],
      binding: SignInLazyPutBinding(),
    ),
    GetPage(
      name: AppRoutes.Account,
      page: () => const AccountPage(),
      middlewares: [
        RouteAuthMiddleware(priority: 1),
      ],
      transition: Transition.circularReveal,
    ),
  ];

  static final unknownRoute = GetPage(
    name: AppRoutes.NotFound,
    page: () => const NotfoundView(),
  );
}
