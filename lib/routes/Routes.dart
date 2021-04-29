import 'package:flutter/material.dart';
import 'package:flutter_app/pages/index/Index.dart';
import 'package:flutter_app/pages/photoGet/PhotoGet.dart';
import 'package:flutter_app/pages/home/Home.dart';

import '../pages/FormPage.dart';
import '../pages/Search.dart';
import '../pages/tabs/Tabs.dart';
import '../pages/user/Login.dart';

final routes = {
  '/': (context) => Tabs(),
  '/home': (context) => Home(),
  '/index': (context) => Index(),
  '/form': (context, {arguments}) => FormPage(arguments: arguments),
  '/search': (context, {arguments}) => Search(arguments: arguments),
  '/user/login': (context, {arguments}) => Login(),
  // 图片获取yemian
  '/photo': (context) => PhotoGet(),
};

var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          // settings: settings,
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));

      return route;
    }
  }
};

class ScaleRoute extends PageRouteBuilder {
  final Widget page;

  ScaleRoute(this.page)
      : super(
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) {
            return page;
          },
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            return ScaleTransition(
              alignment: Alignment.bottomLeft,
              scale: Tween(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
              ),
              child: child,
            );
          },
          transitionDuration: Duration(seconds: 1),
        );
}
