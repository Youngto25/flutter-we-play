import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/counter_model.dart';
import 'package:flutter_app/model/language_model.dart';
import 'package:provider/provider.dart';

class User extends StatefulWidget {
  User({Key key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  List pickerChildren = [
    {"name": "中文", "code": "zh"},
    {"name": "English", "code": "en"},
  ];
  int selectedValue = 0;
  String selectedGender = "中文";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      height: 360,
                      color: Colors.white,
                      child: ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            width: double.infinity,
                            height: 300.0,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                  Color(0xffE82950),
                                  Color(0xffFE7E5E)
                                ])),
                          ))),
                  Positioned(
                      top: 100.0,
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    // spreadRadius: 10.0,
                                    blurRadius: 30.0,
                                    color: Colors.black.withOpacity(0.1))
                              ]),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Image.asset(
                                      'images/bar_user_click.png',
                                      width: 80.0,
                                      height: 80.0,
                                    ),
                                  ))),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              '${context.watch<Language>().language["nickname"]}：Flutter D',
                              style: TextStyle(fontSize: 16.0))
                        ],
                      )),
                  Positioned(
                      bottom: 0,
                      child: Column(
                        children: [
                          Container(
                            width: size.width,
                            height: 150,
                            // color: Colors.green,
                          )
                        ],
                      ))
                ],
              ),
              Expanded(
                  flex: 1,
                  child: ListView(
                    padding: EdgeInsets.only(top: 0, bottom: 0),
                    children: [
                      Container(
                        width: double.infinity,
                        height: 60,
                        color: Colors.white,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: InkWell(
                          onTap: () {
                            _didClickSelectedGender();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("默认语言",
                                  style: Theme.of(context).textTheme.subtitle1),
                              Text(selectedGender)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        height: 60,
                        color: Colors.white,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: InkWell(
                          onTap: () {
                            print(["inkwell"]);
                            Navigator.of(context).pushNamed('/home');
                          },
                          child: Row(
                            children: [
                              Text("Picture",
                                  style: Theme.of(context).textTheme.subtitle1)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }

  //点击选择性别
  void _didClickSelectedGender() {
    selectedValue = 0;
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        color: Colors.white,
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("取消")),
                    Text(
                      "请选择语言",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    FlatButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.pop(context);
                        this.setState(() {
                          selectedGender =
                              pickerChildren[selectedValue]["name"];
                        });
                        context.read<Language>().changeLanguage(
                            type: pickerChildren[selectedValue]["code"]);
                      },
                      child: Text("确定"),
                    ),
                  ],
                ),
                Expanded(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 22,
                    ),
                    child: CupertinoPicker(
                      // diameterRatio: 1.5,
                      // offAxisFraction: 0.2, //轴偏离系数
                      scrollController: FixedExtentScrollController(
                          initialItem: initPicker()),
                      squeeze: 1.2,
                      useMagnifier: true, //使用放大镜
                      magnification: 1.2, //当前选中item放大倍数
                      itemExtent: 50, //行高
                      onSelectedItemChanged: (value) {
                        selectedValue = value;
                      },
                      children: pickerChildren.map((data) {
                        return Center(
                          child:
                              Text(data["name"], style: TextStyle(height: 1.4)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  // 初始化选项位置
  int initPicker() {
    int result =
        pickerChildren.indexWhere((vo) => vo["name"] == selectedGender);
    return result;
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0.0, 200);
    path.quadraticBezierTo(
        size.width / 2, size.height * 0.3, size.width, size.height - 100);
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, 0.0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
