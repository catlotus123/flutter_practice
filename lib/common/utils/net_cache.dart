import 'package:flutter_practice/common/utils/cache.dart';
import 'package:flutter_practice/common/utils/storage.dart';
import 'package:dio/dio.dart';

class CacheObject {
  Response response;
  int timeStamp;
  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

class NetCache extends Interceptor {
  var cache = <String, CacheObject>{};

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!CACHE_ENABLE) return;
    bool refresh = options.extra['refresh'] == true;
    bool cacheDisk = options.extra['cacheDisk'] == true;
    if (refresh) {
      if (options.extra['list'] == true) {
        cache.removeWhere((key, value) => key.contains(options.path));
      } else {
        delete(options.uri.toString());
      }
      if (cacheDisk) {
        await StorageUtil().remove(options.uri.toString());
      }
      handler.next(options);
      return;
    }
// get 请求，开启缓存
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra["cacheKey"] ?? options.uri.toString();

      // 策略 1 内存缓存优先，2 然后才是磁盘缓存

      // 1 内存缓存
      var ob = cache[key];
      if (ob != null) {
        //若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            CACHE_MAXAGE) {
          handler.resolve(Response(
              requestOptions: options, statusCode: 200, data: ob.response));
          return;
        } else {
          //若已过期则删除缓存，继续向服务器请求
          cache.remove(key);
        }
      }

      // 2 磁盘缓存
      if (cacheDisk) {
        var cacheData = StorageUtil().getJson(key);
        if (cacheData != null) {
          handler.resolve(Response(
              requestOptions: options, statusCode: 200, data: cacheData));
          return;
        }
      }
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // 如果启用缓存，将返回结果保存到缓存
    if (CACHE_ENABLE) {
      await _saveCache(response);
    }
    super.onResponse(response, handler);
  }

  Future<void> _saveCache(Response object) async {
    RequestOptions options = object.requestOptions;

    // 只缓存 get 的请求
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      // 策略：内存、磁盘都写缓存

      // 缓存key
      String key = options.extra["cacheKey"] ?? options.uri.toString();

      // 磁盘缓存
      if (options.extra["cacheDisk"] == true) {
        await StorageUtil().setJson(key, object.data);
      }

      // 内存缓存
      // 如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if (cache.length == CACHE_MAXCOUNT) {
        cache.remove(cache[cache.keys.first]);
      }

      cache[key] = CacheObject(object);
    }
  }

  void delete(String key) {
    cache.remove(key);
  }
}
