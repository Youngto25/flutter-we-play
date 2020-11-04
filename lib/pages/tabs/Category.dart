import 'package:flutter/material.dart';

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
        appBar: AppBar(title: Row(children: [Expanded(child: TabBar(tabs: [Tab(text: '热销'),Tab(text: '推荐')],),)],)),
        body: TabBarView(children: [
          ListView(children: [Text('000sdf'),Text('00f0sdfasf')],),
          ListView(children: [Text('000sdf'),Text('00f0sdfasf')],),
        ],),
        ),
      length: 2);
  }
}