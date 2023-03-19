import 'dart:io';

import 'package:flutter_practice/common/entity/user.dart';
import 'package:dio/dio.dart';

class UserApi {
  static var dio = Dio(
    BaseOptions(
      baseUrl: 'https://www.wanandroid.com/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 10),
      // 5s
      headers: {
        HttpHeaders.userAgentHeader: 'dio',
        'api': '1.0.0',
      },
      contentType: Headers.formUrlEncodedContentType,
      // Transform the response data to a String encoded with UTF8.
      // The default value is [ResponseType.JSON].
      responseType: ResponseType.json,
    ),
  );

  static Future<LoginResponse> login(
      {required UserLoginRequestEntity params}) async {
    // var response =
    //     await HttpUtil().post('/user/login', context: context, params: params);

    var response = await dio.post(
      '/user/login',
      data: params.toJson(),
    );
    return LoginResponse.fromJson(response.data);
  }

  static Future<RegisterResponse> register(
      {required UserRegisterRequestEntity params}) async {
    // var response = await HttpUtil()
    //     .post('/user/register', context: context, params: params);

    var response = await dio.post('user/register', data: params.toJson());
    var data = response.data;
    return RegisterResponse.fromJson(data);
  }
}
