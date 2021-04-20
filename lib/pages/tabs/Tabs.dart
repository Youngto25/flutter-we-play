import 'package:flutter/material.dart';
import 'package:flutter_app/pages/index/Index.dart';
import 'package:flutter_app/pages/tabs/Setting.dart';
import 'package:flutter_app/pages/user/User.dart';

class Tabs extends StatefulWidget {
  final index;
  Tabs({Key key, this.index = 2}) : super(key: key);

  @override
  _TabsState createState() => _TabsState(this.index);
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 2;

  PageController _pageController;

  _TabsState(index) {
    this._currentIndex = index;
  }

  void initState() {
    super.initState();
    this._pageController = PageController(initialPage: this._currentIndex);
  }

  List<Widget> _pageList = [Index(), Setting(), User()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(255, 50, 50, 1),
        onPressed: () {
          print('click');
          Navigator.of(context).pushNamed("/photo");
        },
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // persistentFooterButtons: [Text('niaho'),Text('niaho')],
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: this._pageController,
        children: this._pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex,
        onTap: (int index) {
          if(index == 1){
            return;
          }
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
              icon: Image.asset('images/bar_home_normal.png',
                  width: 24, height: 24),
              activeIcon: Image.asset('images/bar_home_click.png',
                  width: 24, height: 24),
              title: Text('首页', style: TextStyle(fontSize: 12))),
          BottomNavigationBarItem(
              icon: Image.asset('images/bar_home_normal.png',
                  width: 1, height: 1),
              activeIcon: Image.asset('images/bar_home_click.png',
                  width: 1, height: 1),
              title: Text('', style: TextStyle(fontSize: 12))),
          BottomNavigationBarItem(
              icon: Image.asset('images/bar_user_normal.png',
                  width: 24, height: 24),
              activeIcon: Image.asset('images/bar_user_click.png',
                  width: 24, height: 24),
              title: Text('我的', style: TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}
