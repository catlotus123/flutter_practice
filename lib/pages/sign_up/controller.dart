import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  RxString rxName = ''.obs;

  final passController = TextEditingController();
  RxString rxPass = ''.obs;

  final repassController = TextEditingController();
  RxString rxrepass = ''.obs;

  @override
  void onInit() {
    nameController.addListener(() {
      rxName.value = nameController.text;
    });
    passController.addListener(() {
      rxPass.value = passController.text;
    });
    repassController.addListener(() {
      rxrepass.value = passController.text;
    });
    super.onInit();
  }
}
