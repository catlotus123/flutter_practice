import 'package:flutter_practice/common/api/user.dart';
import 'package:flutter_practice/common/entity/user.dart';
import 'package:flutter_practice/common/utils/validator.dart';
import 'package:flutter_practice/common/values/colors.dart';
import 'package:flutter_practice/common/widgets/app.dart';
import 'package:flutter_practice/common/widgets/button.dart';
import 'package:flutter_practice/common/widgets/input.dart';
import 'package:flutter_practice/common/widgets/toast.dart';
import 'package:flutter_practice/pages/sign_up/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpPage extends GetView<SignupController> {
  const SignUpPage({super.key});

  // 返回上一页
  _handleNavPop() {
    // context.go('/signin');
    Get.back();
  }

  // 执行注册操作
  _handleSignUp() async {
    if (!duCheckStringLength(controller.nameController.value.text, 5)) {
      toastInfo(msg: '用户名不能小于5位');
      return;
    }
    // if (!duIsEmail(_emailController.value.text)) {
    //   toastInfo(msg: '请正确输入邮件');
    //   return;
    // }
    if (!duCheckStringLength(controller.passController.value.text, 6)) {
      toastInfo(msg: '密码不能小于6位');
      return;
    }
    if (!duCheckStringLength(controller.repassController.value.text, 6)) {
      toastInfo(msg: '密码不能小于6位');
      return;
    }
    UserRegisterRequestEntity params = UserRegisterRequestEntity(
      username: controller.nameController.value.text,
      password: controller.passController.value.text,
      repassword: controller.repassController.value.text,
    );

    RegisterResponse registerResponse = await UserApi.register(
      params: params,
    );
    if (registerResponse.errorCode == 0) {
      _handleNavPop();
    } else {
      toastInfo(msg: registerResponse.errorMsg);
    }
  }

  // 注册表单
  Widget _buildInputForm() {
    return Container(
      width: 295.w,
      // height: 204,
      margin: EdgeInsets.only(top: 49.h),
      child: Column(
        children: [
          // fullName input
          inputTextEdit(
            controller: controller.nameController,
            keyboardType: TextInputType.text,
            hintText: "Full name",
            marginTop: 0,
          ),
          // password input
          inputTextEdit(
            controller: controller.passController,
            keyboardType: TextInputType.visiblePassword,
            hintText: "Password",
            isPassword: true,
          ),

          // repassword input
          inputTextEdit(
            controller: controller.repassController,
            keyboardType: TextInputType.visiblePassword,
            hintText: "Password",
            isPassword: true,
          ),
          // 创建
          Container(
            height: 44.h,
            margin: EdgeInsets.only(top: 15.h),
            child: btnFlatButtonWidget(
              onPressed: () {
                _handleSignUp();
              },
              width: 295,
              fontWeight: FontWeight.w600,
              title: "Create an account",
            ),
          ),
          // Spacer(),

          // Fogot password
          Container(
            height: 22.h,
            margin: EdgeInsets.only(top: 20.h),
            child: MaterialButton(
              onPressed: () {},
              child: Text(
                "Fogot password?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondaryElementText,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  height: 1, // 设置下行高，否则字体下沉
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 有账号
  Widget _buildHaveAccountButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: btnFlatButtonWidget(
        onPressed: _handleNavPop,
        width: 294,
        gbColor: AppColors.secondaryElement,
        fontColor: AppColors.primaryText,
        title: "I have an account",
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: transparentAppBar(
          context: context,
          leading: IconButton(
              onPressed: _handleNavPop,
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.primaryText,
              )),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  toastInfo(msg: 'z这是注册界面');
                },
                icon: const Icon(
                  Icons.info_outline,
                  color: AppColors.primaryText,
                ))
          ]),
      body: Center(
        child: Column(
          children: [
            const Divider(
              height: 1,
            ),
            _buildInputForm(),
            const Spacer(),
            _buildHaveAccountButton(),
          ],
        ),
      ),
    );
  }
}
