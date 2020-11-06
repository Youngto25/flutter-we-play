import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _phone.text = '';
    this.getList();
  }

  void getList() async {}
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Column(
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/form',
                      arguments: {'pid': 999});
                },
                child: Text('跳转到表单页面并传值'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/search',
                      arguments: {'goodsId': 888});
                },
                child: Text('跳转到搜索页面'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/user/login');
                },
                child: Text(
                  '跳转到登录页面',
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
