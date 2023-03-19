import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_practice/common/utils/cache.dart';
import 'package:flutter_practice/common/utils/net_cache.dart';
import 'package:flutter_practice/common/values/server.dart';
import 'package:flutter_practice/common/widgets/toast.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class ErrorEntity implements Exception {
  int code;
  String? message;
  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == null) return 'Exception';
    return 'Exception: code $code, $message';
  }
}

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;

  late Dio dio;
  CancelToken cancelToken = CancelToken();
  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: SERVER_API_URL,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 5),
      headers: {},
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    dio = Dio(options);
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      handler.next(options);
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      handler.next(response);
    }, onError: (DioError e, ErrorInterceptorHandler handler) {
      ErrorEntity eInfo = createErrorEntity(e);
      toastInfo(msg: eInfo.message);
      var context = e.requestOptions.extra['context'];
      if (context != null) {
        switch (eInfo.code) {
          case 401:
            break;
          default:
        }
      }
      handler.next(e);
    }));

    dio.interceptors.add(NetCache());
  }

  /*
   * error统一处理
   */
  // 错误信息
  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        {
          return ErrorEntity(code: -1, message: "请求取消");
        }
      case DioErrorType.connectionTimeout:
        {
          return ErrorEntity(code: -1, message: "连接超时");
        }
      case DioErrorType.sendTimeout:
        {
          return ErrorEntity(code: -1, message: "请求超时");
        }
      case DioErrorType.receiveTimeout:
        {
          return ErrorEntity(code: -1, message: "响应超时");
        }

      case DioErrorType.badResponse:
        {
          try {
            int errCode = error.response?.statusCode ?? 506;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 400:
                {
                  return ErrorEntity(code: errCode, message: "请求语法错误");
                }
              case 401:
                {
                  return ErrorEntity(code: errCode, message: "没有权限");
                }
              case 403:
                {
                  return ErrorEntity(code: errCode, message: "服务器拒绝执行");
                }
              case 404:
                {
                  return ErrorEntity(code: errCode, message: "无法连接服务器");
                }
              case 405:
                {
                  return ErrorEntity(code: errCode, message: "请求方法被禁止");
                }
              case 500:
                {
                  return ErrorEntity(code: errCode, message: "服务器内部错误");
                }
              case 502:
                {
                  return ErrorEntity(code: errCode, message: "无效的请求");
                }
              case 503:
                {
                  return ErrorEntity(code: errCode, message: "服务器挂了");
                }
              case 505:
                {
                  return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
                }
              default:
                {
                  // return ErrorEntity(code: errCode, message: "未知错误");
                  return ErrorEntity(
                      code: errCode, message: error.response?.statusMessage);
                }
            }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: "未知错误");
          }
        }
      default:
        {
          return ErrorEntity(code: -1, message: error.message);
        }
    }
  }

  void cancelRequests(CancelToken token) {
    token.cancel('cancelled');
  }

  /// 读取本地配置
  // Map<String, dynamic>? getAuthorizationHeader() {
  //   Map<String, String>? headers;
  //   String? accessToken = Global.profile?.accessToken;
  //   if (accessToken != null) {
  //     headers = {
  //       'Authorization': 'Bearer $accessToken',
  //     };
  //   }
  //   return headers;
  // }

  Future get(
    String path, {
    dynamic params,
    Options? options,
    bool refresh = false,
    bool noCache = !CACHE_ENABLE,
    bool list = false,
    String cacheKey = '',
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(extra: {
      'refresh': refresh,
      'noCache': noCache,
      'list': list,
      'cacheKey': cacheKey,
      'cacheDisk': cacheDisk,
    });
    var response = await dio.get(path,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken);

    return response.data;
  }

  /// restful post 操作
  Future post(
    String path, {
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    // Map<String, dynamic>? authorization = getAuthorizationHeader();
    // if (authorization != null) {
    //   requestOptions = requestOptions.copyWith(headers: authorization);
    // }
    var response = await dio.post(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful patch 操作
  Future patch(
    String path, {
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    // Map<String, dynamic>? authorization = getAuthorizationHeader();
    // if (authorization != null) {
    //   requestOptions = requestOptions.copyWith(headers: authorization);
    // }
    var response = await dio.patch(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful delete 操作
  Future delete(
    String path, {
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    // Map<String, dynamic>? authorization = getAuthorizationHeader();
    // if (authorization != null) {
    //   requestOptions = requestOptions.copyWith(headers: authorization);
    // }
    var response = await dio.delete(path,
        data: params, options: requestOptions, cancelToken: cancelToken);
    return response.data;
  }

  /// restful post form 表单提交操作
  Future postForm(
    String path, {
    dynamic params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    // Map<String, dynamic>? authorization = getAuthorizationHeader();
    // if (authorization != null) {
    //   requestOptions = requestOptions.copyWith(headers: authorization);
    // }
    var response = await dio.post(path,
        data: FormData.fromMap(params),
        options: requestOptions,
        cancelToken: cancelToken);
    return response.data;
  }
}
