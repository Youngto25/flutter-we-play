import 'package:flutter/material.dart';
import 'Setting.dart';
import './Category.dart';
import 'Home.dart';

class Tabs extends StatefulWidget {
  final index;
  Tabs({Key key,this.index = 0}) : super(key: key);

  @override
  _TabsState createState() => _TabsState(this.index);
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;

  PageController _pageController;

  _TabsState(index){
    this._currentIndex = index;
  }

  void initState() {
    super.initState();
    this._pageController = PageController(initialPage: this._currentIndex);
  }

  List<Widget> _pageList = [Home(),Category(),Setting(),Setting()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){print('click');},),
        body: PageView(
          controller: this._pageController,
          children: this._pageList,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._currentIndex,
          onTap: (int index){
            setState(() {
              this._currentIndex = index;
              this._pageController.jumpToPage(this._currentIndex);
            });
          },
          selectedItemColor: Color.fromRGBO(255, 50, 50, 1),
          unselectedItemColor: Color.fromRGBO(153, 153, 153, 1),
          
          type: BottomNavigationBarType.fixed, //配置底部tabs可以有多个按钮
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('images/bar_home_normal.png',width: 24,height: 24),
              activeIcon: Image.asset('images/bar_home_click.png',width: 24,height: 24),
              title: Text('首页',style: TextStyle(fontSize: 12))
            ),
            BottomNavigationBarItem(
              icon: Image.asset('images/bar_pintuan_normal.png',width: 24,height: 24),
              activeIcon: Image.asset('images/bar_pintuan_click.png',width: 24,height: 24),
              title: Text('拼团',style: TextStyle(fontSize: 12))
            ),
            BottomNavigationBarItem(
              icon: Image.asset('images/bar_task_normal.png',width: 24,height: 24),
              activeIcon: Image.asset('images/bar_task_click.png',width: 24,height: 24),
              title: Text('活动',style: TextStyle(fontSize: 12))
            ),
            BottomNavigationBarItem(
              icon: Image.asset('images/bar_user_normal.png',width: 24,height: 24),
              activeIcon: Image.asset('images/bar_user_click.png',width: 24,height: 24),
              title: Text('个人中心',style: TextStyle(fontSize: 12))
            ),
          ],
        ),
      );
  }
}