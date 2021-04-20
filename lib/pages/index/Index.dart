import 'package:flutter/material.dart';
import 'package:flutter_app/public.dart';

class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(title: "欢迎来到—We Play", elevation: 0),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(left: 10, right: 10),
          color: Colors.white,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              inputWidget(),
              inputWidget(lable: "次数"),
              ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                      width: double.infinity,
                      height: 50,
                      color: Colors.yellow.withOpacity(0.8),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/photo');
                          },
                          child: Text('提交', style: TextStyle(fontSize: 18)))))
            ],
          )),
    );
  }

  Widget inputWidget({lable}) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
              // icon: Icon(Icons.text_fields),
              // labelText: lable,
              labelStyle: TextStyle(color: Colors.black38),
              focusColor: Colors.black54,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.5))),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      BorderSide(color: Colors.black.withOpacity(0.2)))),
          // onChanged: _textFieldChanged,
        ));
  }
}
