import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  Map arguments;
  Search({Key key,this.arguments}) : super(key: key);

  @override
  _SearchState createState() => _SearchState(arguments: this.arguments);
}

class _SearchState extends State<Search> {
  Map arguments;
  _SearchState({this.arguments});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索')
      ),
      body: Text('search page${arguments['goodsId']}'),
    );
  }
}