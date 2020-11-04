import 'package:flutter/material.dart';
import '../../utils/http/request.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List _list = [];
  @override
  void initState () {
    // TODO: implement initState
    super.initState();
    this.getList();
  }
  void getList() async {
    var response = await DioUtil().get('pintuan/listPintuan',pathParams: {"category": 2});
    this.setState(() {
      this._list = response["data"]["list"];
    });
    print(this._list);
  }

  Widget _getListData(context,index){
    return PintuanItem(item: this._list[index]);
  }
  @override
  Widget build(BuildContext context) {
    return Container(child: 
      Padding(
        padding: EdgeInsets.all(12),
        child:  ListView.builder(
          itemCount: this._list.length,
          itemBuilder: this._getListData,
        )
      ,)
    );
  }
}

class PintuanItem extends StatefulWidget {
  var item;
  PintuanItem({Key key,this.item}) : super(key: key);

  @override
  _PintuanItemState createState() => _PintuanItemState(this.item);
}

class _PintuanItemState extends State<PintuanItem> {
  var item;
  _PintuanItemState(this.item);
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),child: 
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        verticalDirection: VerticalDirection.down,
        children: [
      Container(child: 
        Image.network(
          this.item["picUrl"],
          fit: BoxFit.contain,
          loadingBuilder: (BuildContext context,Widget child,ImageChunkEvent loadingProgress){
            if(loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes : null
              ),);
          },
          ),
          height: 100,
          width: 100,
      ),
      Container(child: Column(children: [
        Text(this.item["name"],textAlign: TextAlign.left,),
        Text(this.item["brief"],softWrap: true,textAlign: TextAlign.left,)
      ],)),
    ],)
    );
  }
}