import 'package:flutter/material.dart';
import 'package:flutter_app/components/AppBarX.dart';

class User extends StatefulWidget {
  User({Key key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        // appBar: AppBarX(
        //   title: "个人中心",
        //
        // ),
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
                            Text('昵称：Flutter D',
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
                      children: [Center(child: Text("个人中心"))],
                    ))
              ],
            )));
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
