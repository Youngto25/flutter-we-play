import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/public.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:convert';

const basicUrl = 'http://testnet.pinduozhuan.com/wx';

class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

setToken(token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final setTokenResult = await prefs.setString('user_token', token);
  if (setTokenResult) {
  } else {}
}

getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // print(prefs.getString('user_token'));
}

class HttpManage {
  static var headers = {
    "Accept": "application/json",
    "ResponseType": ResponseType.plain,
    "X-Litemall-Token": ""
  };
  static Dio dio;
  HttpManage() {
    debugPrint("dio init");
    dio = Dio();
    dio.options.headers = headers;
  }
  static request(url, params, method, {onReceiveProgress, server}) async {
    Response response;
    switch (method) {
      case 'get':
        response = await _get(url, params, server: server);
        break;
      case 'post':
        response = await _post(url, params);
        break;
      case "download":
        response = await _download(url, onReceiveProgress);
    }
    if (true) {
      getToken();
    }
    print('response');
    print(response);
    // if (response.data["errno"] != 0) {
    //   Fluttertoast.showToast(
    //     msg: response.data["errmsg"],
    //   );
    // }
    return response;
  }

  static Future _get(url, params, {server}) async {
    String path = "${server != null ? server : basicUrl}/$url";
    print(["get request=====>", path]);
    return await dio.get(path, queryParameters: params);
  }

  static Future _post(url, params) async {
    return await dio.post("$basicUrl/$url", data: params);
  }

  static Future _download(url, onReceiveProgress) async {
    print('download');
    return await dio.download(url, "/", onReceiveProgress: (a, b) {
      print(['download', a, b]);
    });
  }

  // 获取天气信息
  static getWeatherInfo({city = 110101}) async {
    var response = await request(
        'weatherInfo',
        {"key": GAODE_KEY, "city": city, "extensions": "all", "output": "JSON"},
        "get",
        server: GAODE_WEATHER_SERVER);
    return response;
  }
}
