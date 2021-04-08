import 'package:flutter/material.dart';
import 'package:flutter_app/pages/photoGet/PhotoGet.dart';

import '../pages/FormPage.dart';
import '../pages/Search.dart';
import '../pages/tabs/Tabs.dart';
import '../pages/user/Login.dart';

final routes = {
  '/': (context, {index}) => Tabs(index: index = 1),
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
