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
  Widget build(BuildContext context) {
    // return Center(child: Text('你好jiao',textDirection: TextDirection.ltr,style: TextStyle(fontSize: 40.0,color: Color.fromRGBO(233, 233, 234, 0.4)),));
    return Center(child: Container(
      // child: Image.network(
      //   'http://oss.pinduozhuan.com/ksl9pymxvpzuvh5mc1m5.png',
      //   fit: BoxFit.contain
      //   ),
      child: ClipOval(child: Image.asset(
        'images/task_invite.jpg',height: 200,width: 200,fit: BoxFit.cover),
      ),
      // width: 300,
      // height: 300,
      // decoration: BoxDecoration(
      //   color: Colors.yellow,
      //   // borderRadius: BorderRadius.all(Radius.circular(150))
      //   borderRadius: BorderRadius.circular(150),
      //   image: DecorationImage(
      //     image: NetworkImage('http://oss.pinduozhuan.com/ksl9pymxvpzuvh5mc1m5.png'),
      //     fit: BoxFit.cover
      //   ),        
      // ),
    ));
  }
}