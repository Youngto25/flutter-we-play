import 'package:flutter/material.dart';
import 'pages/tabs/Tabs.dart';
import './routes/Routes.dart';


void main(){
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false, //去掉debug
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black38,fontSize: 12),
        )
      ),
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
  // This widget is the root of your application.
}



class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int countNum = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Chip(label: Text('nihao${this.countNum}'),),
      RaisedButton(
        onPressed: (){
          setState((){
            this.countNum++;
          });
        },
        child: Text('click me')
      )
    ],);
  }
}

class HomeContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyButton('click me');
  }
}

class MyButton extends StatelessWidget{
  final String text;
  const MyButton(this.text,{Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      child: Text(this.text),
      textColor: Theme.of(context).accentColor,
      onPressed: (){
        
      },
    );
  }
}

class HomeContent1 extends StatelessWidget{
  Widget build(BuildContext context) {
    // return Center(child: Text('你好jiao',textDirection: TextDirection.ltr,style: TextStyle(fontSize: 40.0,color: Color.fromRGBO(233, 233, 234, 0.4)),));
    return Column(
      children: <Widget>[
        Row(
          children: [
          Expanded(child: 
            Container(
              height: 180,
              color: Colors.black,
              child: Text('你好'),
            ),)
        ,]),
        SizedBox(height: 10),
        Row(children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              height: 180,
              child: Image.asset('images/task_invite.jpg',fit: BoxFit.fill),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Container(
              height: 180,
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 85,
                    child: Image.asset('images/task_invite.jpg',fit: BoxFit.fill),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 85,
                    child: Image.asset('images/task_invite.jpg',fit: BoxFit.fill),
                  ),
                ],
              )
            ),
          )
        ],)
      ],
    );
  }
}