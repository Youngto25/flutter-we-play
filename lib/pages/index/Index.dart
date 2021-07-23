import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/counter_model.dart';
import 'package:flutter_app/model/language_model.dart';
import 'package:flutter_app/public.dart';
import 'package:flutter_app/utils/date_util.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  List<int> playCountList = [10, 15, 20, 30, 40, 50, 100];
  int selectCount = 0;
  List<Finish> finishList = [];
  int finishCount = 0;
  String now = '';
  String type = '俯卧撑';

  @override
  void initState() {
    now = DateTime.now().toString().substring(0, 10);
    super.initState();
  }

  // 计算累计完成次数
  void computeFinishCount() {
    int count = 0;
    finishList.forEach((Finish vo) {
      count += vo.getCount();
    });
    finishCount = count;
    this.setState(() {});
  }

  // 确定完成次数
  void alreadySelectCount() {
    if (selectCount == 0) {
      return;
    }

    Finish finish = new Finish(this.type, this.selectCount, new DateTime.now());
    finishList.add(finish);
    selectCount = 0;
    this.computeFinishCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
          title: "$now${context.watch<Language>().language["welcome"]}—We Play",
          brightness: Brightness.light,
          elevation: 0),
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
              // inputWidget(),
              // inputWidget(lable: "次数"),
              Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Center(
                      child: Text('今日累计完成$finishCount次',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)))),
              GridView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100, //子控件最大宽度为100
                  childAspectRatio: 2, //宽高比为1:2
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                padding: EdgeInsets.all(10),
                children: List.generate(
                  playCountList.length,
                  (index) {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: selectCount == playCountList[index]
                                  ? Color.fromRGBO(255, 50, 50, 1)
                                  : Colors.black.withOpacity(0.1),
                            ),
                            child: FlatButton(
                                onPressed: () {
                                  this.setState(() {
                                    selectCount = playCountList[index];
                                  });
                                },
                                child: Text(
                                  playCountList[index].toString(),
                                  style: TextStyle(
                                      color: selectCount == playCountList[index]
                                          ? Colors.white
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .color),
                                ))));
                  },
                ),
              ),
              SizedBox(height: 20),
              ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      width: double.infinity,
                      height: 50,
                      color: selectCount > 0
                          ? Color.fromRGBO(255, 50, 50, 1)
                          : Colors.black.withOpacity(0.1),
                      child: FlatButton(
                          onPressed: () {
                            this.alreadySelectCount();
                          },
                          child: Text(
                              selectCount > 0
                                  ? '已选择$selectCount次，确定'
                                  : '选择完成次数',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white))))),
              Expanded(
                flex: 1,
                child: ListView(
                  padding: EdgeInsets.only(top: 10.0),
                  children: finishList.map<Widget>((Finish vo) {
                    return Container(
                        width: double.infinity,
                        height: 60.0,
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1.0, color: Color(0xfff1f1f1)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(vo.getType()),
                            Row(children: [
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(vo.getCount().toString()),
                              ),
                              Text(
                                vo.getCreatedTime().toString().substring(0, 16),
                              )
                            ])
                          ],
                        ));
                  }).toList(),
                ),
              )
              // RaisedButton(
              //     onPressed: () {
              //       debugPrint("开始下载");
              //       HttpManage.request(
              //           "http//storage.360buyimg.com/jdmobile/JDMALL-PC2.apk",
              //           null,
              //           "download",
              //           onReceiveProgress: downloadProgress);
              //     },
              //     child: Text('下载'))
            ],
          )),
    );
  }

  Future downloadProgress(a, b) async {
    print(["downloadProgress", a, b]);
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
