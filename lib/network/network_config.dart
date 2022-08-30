
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:tchat/database/floor_init.dart';
import 'package:tchat/network/api_provider.dart';

import '../firebase/database/firestore_database.dart';

abstract class NetworkConfig {
  final String baseUrl = 'http://mobile.vietravel.com/api/';
  //final String baseUrl = 'http://108.108.110.22:9999//api/';
  //final String baseUrl = "http://108.108.110.22:8080/api/";//http://101.53.10.57:8080/
  final String apiKey = '973e0b034af17e62d03ca343795ac965';
  final String kLanguageDefault = 'vn';
  final String kTypeDefault = '2'; //1: android; 2: iOS
  String kDeviceCodeDefault = ''; //1: android; 2: iOS
  late ApiProvider restApi ;

   Options cacheOptions= buildCacheOptions(const Duration(days: 3), maxStale: const Duration(days: 7),forceRefresh: true);

  String? token='';
  NetworkConfig.internal(){
    DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
    Dio _dio= Dio();
    _dio.options.baseUrl=baseUrl;
    //   _dio!.options.receiveTimeout = 3000;
    _dio.interceptors.add(AppInterceptors());
    _dio.interceptors.add(_dioCacheManager.interceptor);
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(requestBody: true,responseBody: true));
    }
    restApi =ApiProvider(_dio, baseUrl: baseUrl);
  }
  // NetworkConfig() {
  //   var dio = Dio();
  //   Map<String, dynamic> requestHeaders = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     //'Authorization': '$token',
  //     'Language': 'vi'
  //   };
  //   dio.options = BaseOptions(
  //     // receiveTimeout: 7000,
  //     // connectTimeout: 7000,
  //     contentType: 'application/json',
  //    //  headers: requestHeaders,
  //
  //   );
  //   if (kDebugMode) {
  //     dio.interceptors.add(LogInterceptor(requestBody: true,responseBody: true));
  //   }
  //   restApi =ApiProvider(dio, baseUrl: baseUrl);
  //   //restApi =ApiProvider(dio,token!, baseUrl: baseUrl);
  // }

}

class AppInterceptors extends InterceptorsWrapper {
  // bool? token;
  // AppInterceptors(this.token);
  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
   //  await SingletonStorage.getInstance();
     //var token = await SingletonStorage.getDeviceToken();// todo add header
   //    token??'';
    String token='';
   // print('token $token');

    Map<String, dynamic> requestHeaders = {
      'contentType': 'application/json',// todo contentType is Error booking
      'Authorization': token,
      'Language': 'vi',
      'Connection':'keep-alive'
    };
    options.headers =requestHeaders;
    return super.onRequest(options, handler);
  }
  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    // print('response ${response.data.toString()}');
    return super.onResponse(response, handler);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) {
    // var url = err.request.uri;
    print("************************************************");
    print(err);
    super.onError(err, handler);
  }
}