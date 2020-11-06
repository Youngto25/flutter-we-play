import 'package:flutter/material.dart';
import './routes/Routes.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false, //去掉debug
      theme: ThemeData(
          primaryColor: Color.fromRGBO(246, 246, 246, 1),
          brightness: Brightness.light,
          textTheme: TextTheme(
            bodyText1:
                TextStyle(color: Color.fromRGBO(51, 51, 51, 1), fontSize: 14),
            bodyText2: TextStyle(
                color: Color.fromRGBO(255, 31, 57, 1),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          )),
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
    return Column(
      children: [
        Chip(
          label: Text('nihao${this.countNum}'),
        ),
        RaisedButton(
            onPressed: () {
              setState(() {
                this.countNum++;
              });
            },
            child: Text('click me'))
      ],
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyButton('click me');
  }
}

class MyButton extends StatelessWidget {
  final String text;
  const MyButton(this.text, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      child: Text(this.text),
      textColor: Theme.of(context).accentColor,
      onPressed: () {},
    );
  }
}

class HomeContent1 extends StatelessWidget {
  Widget build(BuildContext context) {
    // return Center(child: Text('你好jiao',textDirection: TextDirection.ltr,style: TextStyle(fontSize: 40.0,color: Color.fromRGBO(233, 233, 234, 0.4)),));
    return Column(
      children: <Widget>[
        Row(children: [
          Expanded(
            child: Container(
              height: 180,
              color: Colors.black,
              child: Text('你好'),
            ),
          ),
        ]),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                height: 180,
                child: Image.asset('images/task_invite.jpg', fit: BoxFit.fill),
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
                        child: Image.asset('images/task_invite.jpg',
                            fit: BoxFit.fill),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 85,
                        child: Image.asset('images/task_invite.jpg',
                            fit: BoxFit.fill),
                      ),
                    ],
                  )),
            )
          ],
        )
      ],
    );
  }
}
