import 'package:flutter/material.dart';
import '../pintuan/PinList.dart';

class Category extends StatefulWidget {
  Category({Key key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        child: Scaffold(
          appBar: AppBar(
              title: Row(
            children: [
              Expanded(
                child: TabBar(
                  tabs: [Tab(text: '返利高'), Tab(text: '收益稳'), Tab(text: '人气旺')],
                ),
              )
            ],
          )),
          body: TabBarView(
            children: [
              PinList(1),
              PinList(2),
              PinList(3),
            ],
          ),
        ),
        length: 3);
  }
}

