import 'package:flutter/material.dart';
import '../Search.dart';
import '../FormPage.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: [
           RaisedButton(
             onPressed: (){
               Navigator.pushNamed(context,'/form', arguments: {'pid': 999});
             },
             child: Text('跳转到表单页面并传值'),),
           RaisedButton(
             onPressed: (){
               Navigator.pushNamed(context,'/search', arguments: {'goodsId': 888});
              //  Navigator.of(context).push(
              //    MaterialPageRoute(builder: (context)=>Search())
              //  );
             },child: Text('跳转到搜索页面'),)
         ],),
    );
  }
}