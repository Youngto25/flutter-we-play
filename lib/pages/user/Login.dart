import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/http/request.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // var _phone = new TextEditingController(); //初始化时给表单赋值可用
  var _phone;
  var _verify;
  @override
  void initState () {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录')
      ),
      body: Container(
        // color: Colors.red,
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Column(children: [
          Text('手机号快捷登录', style: TextStyle(fontSize: 24.0,color: Color.fromRGBO(51, 51, 51, 1),fontWeight: FontWeight.bold),),
          Text('未注册过的手机号将自动创建账号', style: TextStyle(fontSize: 14.0,color: Color.fromRGBO(153, 153, 153, 1),),),
          TextField(
            decoration: InputDecoration(labelText: '手机号',errorText: '手机号格式不对',errorStyle: TextStyle(color: false ? Colors.transparent : Colors.redAccent),),
            onChanged: (context)=>{setState((){this._phone = context;})},
            keyboardType: TextInputType.number,
          ),
          Row(children: [
            Expanded(child: 
              TextField(
                decoration: InputDecoration(labelText: '验证码'),
                onChanged: (context){setState((){this._verify = context;});},
                keyboardType: TextInputType.number,
              ),
              flex: 4
            ),
            Expanded(child: 
              RaisedButton(onPressed: (){},child: Text('倒计时'),),
              flex: 1
            ,)
          ],),
          RaisedButton(onPressed: (){print(this._phone);print(this._verify);},child: Text('登录')),
          
        ],),
      )
    );
  }
}