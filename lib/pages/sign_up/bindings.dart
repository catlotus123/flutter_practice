import 'package:flutter_practice/pages/sign_up/controller.dart';
import 'package:get/get.dart';

class SignUpLazyPutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(() => SignupController());
  }
}
