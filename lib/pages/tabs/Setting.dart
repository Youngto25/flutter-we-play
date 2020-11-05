import 'package:flutter/material.dart';
import '../../utils/http/request.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List _list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getList();
  }

  void getList() async {
    var response = await HttpManage()
        .request('pintuan/listPintuan', {"category": 2}, 'get');
    this.setState(() {
      this._list = response["data"]["list"];
    });
    var sign = await HttpManage().request('user/sign', {}, 'post');
  }

  Widget _getListData(context, index) {
    return PintuanItem(item: this._list[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.all(12),
      child: ListView.builder(
        itemCount: this._list.length,
        itemBuilder: this._getListData,
      ),
    ));
  }
}

class PintuanItem extends StatefulWidget {
  var item;
  PintuanItem({Key key, this.item}) : super(key: key);

  @override
  _PintuanItemState createState() => _PintuanItemState(this.item);
}

class _PintuanItemState extends State<PintuanItem> {
  var item;
  _PintuanItemState(this.item);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(204, 204, 204, 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: FadeInImage.assetNetwork(
                  placeholder: "images/task_invite.jpg",
                  image: this.item["picUrl"],
                  fit: BoxFit.cover,
                ),
              ),
              height: 100,
              width: 100,
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  decoration: BoxDecoration(color: Colors.red),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: '10',
                                style: TextStyle(color: Colors.blue)),
                            TextSpan(text: '人开团，拼中'),
                            TextSpan(
                                text: '1',
                                style: TextStyle(color: Colors.blue)),
                            TextSpan(text: '人,未拼中全额退款，没人再得'),
                            TextSpan(
                                text: '0.10',
                                style: TextStyle(color: Colors.blue)),
                            TextSpan(text: '元'),
                          ],
                        ),
                      ),
                      Text(
                        this.item["name"],
                        textAlign: TextAlign.left,
                      ),
                      Row(
                        children: [
                          Container(
                              child: Column(
                            children: [Text('0.38元/次')],
                          )),
                          RaisedButton(
                            child: Text('click showToast'),
                            onPressed: () {
                              
                            },
                          )
                        ],
                      ),
                    ],
                  )),
            )
          ],
        ));
  }
}
