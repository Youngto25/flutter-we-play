import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('小明哎i到')
        ),
        body: HomeContent(),
      ),
      theme: ThemeData(
        primarySwatch: Colors.yellow
      )
    );
  }
  // This widget is the root of your application.
}

class HomeContent extends StatelessWidget{
  // 自定义方法
  var listData = [{"title": 'hello'},{"title": 'world'}];
  // List<Widget> _getData() {
  //   List<Widget> list = new List();
  //   for(var i = 0; i < 20; i++) {
  //     list.add(ListTile(
  //       title: Text('hello $i'),
  //     ));
  //   }
  //   return list;
  // }

  List<Widget> _getData() {
    var tempList = listData.map((value){
      return ListTile(
        title: Text(value['title'])
      );
    });
    //此时tempList 需要转为数组，dart map的特点
    return tempList.toList();
  }

  Widget build(BuildContext context) {
    // return Center(child: Text('你好jiao',textDirection: TextDirection.ltr,style: TextStyle(fontSize: 40.0,color: Color.fromRGBO(233, 233, 234, 0.4)),));
    return ListView(
      children: this._getData(),
    );
  }
}