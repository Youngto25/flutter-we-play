import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/config/global.dart';
import 'package:flutter_app/model/counter_model.dart';
import 'package:flutter_app/model/language_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './routes/Routes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 强制竖屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    Global.init().then((_) {
      debugPrint("app init");
      runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Counter()),
          ChangeNotifierProvider(create: (_) => Language()),
        ],
        child: MyApp(),
      ));
    });
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
    return MaterialApp(
      debugShowCheckedModeBanner: true, //去掉debug
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'), // English
        const Locale('he', 'IL'), // Hebrew
        // ... other locales the app supports
      ],
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0.5,
          ),
          primaryColor: Colors.white,
          primaryColorLight: Color(0xffFF7500),
          brightness: Brightness.light,
          scaffoldBackgroundColor: Color(0xfff6f6f6), //背景色
          textTheme: TextTheme(
            bodyText1:
                TextStyle(color: Color(0xff333333), fontSize: 16, height: 1),
            bodyText2:
                TextStyle(color: Color(0xff333333), fontSize: 14, height: 1),
          )),
      initialRoute: '/home',
      onGenerateRoute: onGenerateRoute,
    );
  }
  // This widget is the root of your application.
}
