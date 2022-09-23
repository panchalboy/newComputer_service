import 'package:computer_service/Utils/utils.dart';
import 'package:computer_service/shared_components/comonWidget.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:get_storage/get_storage.dart';

import '../Utils/constants.dart';

class DioClient {
  static final baseUrl = ApibaseUrl;
  static BaseOptions opts = BaseOptions(
    baseUrl: baseUrl,
    responseType: ResponseType.json,
    connectTimeout: 30000,
    receiveTimeout: 30000,
    contentType: 'application/json',
  );

  static Dio addInterceptors(Dio dio) {
    final storage = GetStorage();
    bool isllogedin = storage.read(isLOGGEDIN) ?? false;
    Map<String, dynamic> map = {};
    if (isllogedin) {
      final jwtToken = "Bearer  " + storage.read('token');
      map.update('Authorization', (v) => jwtToken, ifAbsent: () => jwtToken);
    }
    opts.headers = map;
    Dio dio = new Dio(opts);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          return handler.next(response); // continue
        },
        onError: (DioError e, handler) async {
          print(
              'dio client err - -${e.response} - ${e.response?.statusCode} -- ${dio.options.baseUrl} -- ${dio.options.queryParameters}');
          print(
              "ERROR IN API ==> ${e.type} -- ${e.error} -- ${dio.options.baseUrl}");
          if (e.response?.statusCode == 401) {
            toastWidget('Authorization Denied, please login again.');
            onClearLocalSetup();
            return e.error;
          } else if (e.response.statusCode == 400) {
            toastWidget(e.response.data['message']);
            return e.error;
          }
          if (e.response?.statusCode == 422) {
            print("error===${e.error}");
            return e.error;
          } else {
            return e.response?.data['message'];
          }
          handler.next(e);
        },
      ),
    );
    return dio;
  }

  static final dio = Dio(opts);

  Future<Response> getRequest(String url, [dynamic params]) async {
    try {
      final baseRequest = addInterceptors(dio);
      Response response = await baseRequest.get(url, queryParameters: params);
      return response;
    } on DioError catch (e) {
      // Handle error
      return Future.error(e.response);
    }
  }

  Future<Response> postRequest(String url, [dynamic data]) async {
    try {
      final baseRequest = addInterceptors(dio);
      Response response = await baseRequest.post(url, data: data);
      return response;
    } catch (e) {
      // Handle error
      return Future.error(e.response);
    }
  }

  Future<Response> patchRequest(String url, [dynamic data]) async {
    try {
      final baseRequest = addInterceptors(dio);
      Response response = await baseRequest.patch(url, data: data);
      return response;
    } on DioError catch (e) {
      print('ptach err -- ${e.response}');
      // Handle error
      return Future.error(e.response);
    }
  }

  Future<Response> putRequest(String url, [dynamic data]) async {
    try {
      final baseRequest = addInterceptors(dio);
      Response response = await baseRequest.put(url, data: data);
      return response;
    } on DioError catch (e) {
      // Handle error
      return Future.error(e.response);
    }
  }

  Future<Response> deleteRequest(String url, [dynamic data]) async {
    try {
      final baseRequest = addInterceptors(dio);
      Response response = await baseRequest.delete(url, data: data);
      return response;
    } on DioError catch (e) {
      // Handle error
      return Future.error(e.response);
    }
  }
}
