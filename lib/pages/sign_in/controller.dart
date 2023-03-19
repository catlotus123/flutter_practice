import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  final nameController = TextEditingController();
  RxString rxName = ''.obs;

  final passController = TextEditingController();
  RxString rxPass = ''.obs;

  @override
  void onInit() {
    nameController.addListener(() {
      rxName.value = nameController.text;
    });
    passController.addListener(() {
      rxPass.value = passController.text;
    });
    super.onInit();
  }
}
