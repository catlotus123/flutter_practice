import 'package:flutter_practice/common/api/user.dart';
import 'package:flutter_practice/common/entity/user.dart';
import 'package:flutter_practice/common/utils/validator.dart';
import 'package:flutter_practice/common/values/values.dart';
import 'package:flutter_practice/common/widgets/button.dart';
import 'package:flutter_practice/common/widgets/input.dart';
import 'package:flutter_practice/common/widgets/toast.dart';
import 'package:flutter_practice/global.dart';
import 'package:flutter_practice/pages/account/account.dart';
import 'package:flutter_practice/pages/sign_in/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignInPage extends GetView<SigninController> {
  const SignInPage({super.key});

  // final controller = Get.put(SigninController());

  _handleNavSignUp() {
    Get.toNamed("/signin/signup");
  }

  _handleSignIn() async {
    if (!duCheckStringLength(controller.nameController.value.text, 5)) {
      toastInfo(msg: '用户名不能小于5位');
      return;
    }
    if (!duCheckStringLength(controller.passController.value.text, 6)) {
      toastInfo(msg: '密码不能小于6位');
      return;
    }

    UserLoginRequestEntity params = UserLoginRequestEntity(
      username: controller.nameController.value.text,
      password: controller.passController.value.text,
      // password: duSHA256(_passController.value.text)
    );

    LoginResponse loginResponse = await UserApi.login(
      params: params,
    );
    if (loginResponse.errorCode == 0) {
      if (loginResponse.data != null) {
        Global.saveProfile(loginResponse.data!);
        Get.offAll(() => const AccountPage());
      }
    } else {
      toastInfo(msg: loginResponse.errorMsg);
    }
  }

  Widget _buildInputForm() {
    return Container(
      width: 295.w,
      margin: EdgeInsets.only(top: 49.h),
      child: Column(
        children: [
          inputTextEdit(
            controller: controller.nameController,
            keyboardType: TextInputType.name,
            hintText: "Username",
          ),
          inputTextEdit(
            controller: controller.passController,
            keyboardType: TextInputType.visiblePassword,
            hintText: "Password",
            isPassword: true,
          ),
          Container(
            height: 44.h,
            margin: EdgeInsets.only(top: 15.h),
            child: Row(
              children: [
                btnFlatButtonWidget(
                    onPressed: _handleNavSignUp,
                    gbColor: AppColors.thirdElement,
                    title: 'Sign up'),
                const Spacer(),
                btnFlatButtonWidget(
                  onPressed: _handleSignIn,
                  gbColor: AppColors.primaryElement,
                  title: 'Sign in',
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            _buildInputForm(),
          ],
        ),
      ),
    );
  }
}
