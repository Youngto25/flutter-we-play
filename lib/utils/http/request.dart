import 'package:dio/dio.dart';
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
  if(setTokenResult){

  }else{

  }
}

getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // print(prefs.getString('user_token'));
}

class HttpManage{
  var headers = {
    "Accept": "application/json",
    "ResponseType": ResponseType.plain,
    "X-Litemall-Token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ0aGlzIGlzIGxpdGVtYWxsIHRva2VuIiwiYXVkIjoiTUlOSUFQUCIsImlzcyI6IkxJVEVNQUxMIiwiZXhwIjoxNjA0NTY2MzAyLCJ1c2VySWQiOjczLCJpYXQiOjE2MDQ1NTkxMDJ9.Dx5pQ1U7otHWWzC6KTDwZjfveVBfqJbnTfhpJ9apoZ4"
  };
  Dio dio;
  HttpManage() {
    dio = Dio();
    dio.options.headers = this.headers;
  }
  request(url,params,method) async{
    Response response;
    switch (method){
      case 'get': 
        response = await this._get(url,params);
        break;
      case 'post':
        response = await this._post(url,params);
        break;
    }
    if(true){
      getToken();
    }
    print('response');
    print(response);
    if(response.data["errno"] != 0) {
      Fluttertoast.showToast(
        msg: response.data["errmsg"],
      );
    }
    return response.data;
  }

  _get(url,params) async {
    Response response;
    response = await dio.get("$basicUrl/$url", queryParameters: params);
    return response;
  }
  _post(url,params) async {
    Response response;
    response = await dio.post("$basicUrl/$url", data: params);
    return response;
  }
}