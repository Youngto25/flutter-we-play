import 'package:flutter/material.dart';
import './Home.dart';
import './Category.dart';
import 'Setting.dart';

class Tabs extends StatefulWidget {
  final index;
  Tabs({Key key,this.index = 0}) : super(key: key);

  @override
  _TabsState createState() => _TabsState(this.index);
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  _TabsState(index){this._currentIndex = index;}
  List _pageList = [Home(),Category(),Setting()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('小明哎i到')
        ),
        body: this._pageList[this._currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._currentIndex,
          onTap: (int index){
            this.setState(() {
              this._currentIndex = index;
            });
          },
          iconSize: 32.0,
          type: BottomNavigationBarType.fixed, //配置底部tabs可以有多个按钮
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('首页')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text('分类')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('设置')
            ),
          ],
        ),
      );
  }
}