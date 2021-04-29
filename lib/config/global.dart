import 'package:flutter/material.dart';
import 'package:flutter_app/utils/http/request.dart';

class Global {
  static init() async {
    debugPrint("global init");
    HttpManage();
  }
}
