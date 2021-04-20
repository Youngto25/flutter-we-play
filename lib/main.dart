import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './routes/Routes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 强制竖屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xfffafafa));
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: true, //去掉debug
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0.5,
          ),
          // primaryColor: Color(0xffFF7500),
          primaryColor: Colors.white,
          primaryColorLight: Color(0xffFF7500),
          brightness: Brightness.light,
          scaffoldBackgroundColor: Color(0xfff6f6f6), //背景色
          textTheme: TextTheme(
            bodyText1:
                TextStyle(color: Color.fromRGBO(51, 51, 51, 1), fontSize: 14),
            bodyText2: TextStyle(
              color: Color(0xff333333),
              fontSize: 14,
            ),
          )),
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
  // This widget is the root of your application.
}
