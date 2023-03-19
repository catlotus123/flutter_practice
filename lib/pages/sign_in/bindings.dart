import 'package:flutter_practice/pages/sign_in/controller.dart';
import 'package:get/get.dart';

class SignInLazyPutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SigninController>(() => SigninController());
  }
}
