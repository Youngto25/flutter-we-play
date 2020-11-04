import 'package:flutter/material.dart';

import '../pages/FormPage.dart';
import '../pages/Search.dart';
import '../pages/tabs/Tabs.dart';
import '../pages/user/Login.dart';

final routes = {
  '/': (context,{index})=>Tabs(index: index = 2),
  '/form': (context,{arguments})=>FormPage(arguments: arguments),
  '/search': (context,{arguments})=>Search(arguments: arguments),
  '/user/login': (context,{arguments})=>Login(),
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