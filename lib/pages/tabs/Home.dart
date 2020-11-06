import 'package:flutter/material.dart';
import '../../utils/http/request.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  List _list = [];
  int totalSize = 100;
  int currentPage = 1;
  bool theEnd = false;
  String loadMoreText;
  TextStyle loadMoreTextStyle;
  ScrollController _controller = new ScrollController();

  _HomeState() {
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixel = _controller.position.pixels;
      if (maxScroll == pixel && this._list.length < totalSize) {
        setState(() {
          loadMoreText = "正在加载中...";
          loadMoreTextStyle =
              new TextStyle(color: const Color(0xFF4483f6), fontSize: 14.0);
        });
        if(!theEnd){
          loadMoreData();
        }
      } else {
        setState(() {
          loadMoreText = "没有更多数据";
          loadMoreTextStyle =
              new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
        });
      }
    });
  }

  loadMoreData() {
    print('load more');
    this.getList();
  }

  Future _pullToRefresh() async {
    print('refresh');
    this.currentPage = 1;
    this.setState(() {
      theEnd = false;
    });
    this.getList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getList();
  }

  void getList() async {
    var response = await HttpManage()
        .request('pintuan/listPintuan', {"category": 2, "page": this.currentPage}, 'get');
    this.setState(() {
      this._list = this.currentPage == 1 ? response["data"]["list"] : [...this._list, ...response["data"]["list"]];
    });
    if(response["data"]["pages"] > this.currentPage){
      this.currentPage += 1;
    }else{
      setState(() {
        theEnd = true;
      });
    }
    // var sign = await HttpManage().request('user/sign', {}, 'post');
  }

  /**
   * 加载更多进度条
   */
  Widget _buildProgressMoreIndicator() {
    print('loading');
    return new Padding(
      padding: const EdgeInsets.all(15.0),
      child: new Center(
        child: new Text(loadMoreText, style: loadMoreTextStyle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.all(12),
      child: this._list.length == 0
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              color: const Color(0xFF4483f6),
              child: ListView.builder(
                controller: _controller,
                itemCount: this._list.length,
                itemBuilder: (context, index) {
                  if (index == this._list.length) {
                    return _buildProgressMoreIndicator();
                  } else {
                    return PintuanItem(item: this._list[index]);
                  }
                },
              ),
              onRefresh: _pullToRefresh,
            ),
    ));
  }
  bool get wantKeepAlive => true;
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

  String _toString(double price) {
    return price.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.circular(4)),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        padding: EdgeInsets.all(10),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: '10',
                                style: Theme.of(context).textTheme.bodyText2),
                            TextSpan(
                                text: '人开团，拼中',
                                style: Theme.of(context).textTheme.bodyText1),
                            TextSpan(
                                text: '1',
                                style: Theme.of(context).textTheme.bodyText2),
                            TextSpan(
                                text: '人,未拼中全额退款，没人再得',
                                style: Theme.of(context).textTheme.bodyText1),
                            TextSpan(
                                text: '0.10',
                                style: Theme.of(context).textTheme.bodyText2),
                            TextSpan(
                                text: '元',
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            // this._toString(),
                            this.item["name"],
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(width: 10),
                          Text(
                            this._toString(this.item["price"]),
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(255, 31, 57, 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                          child: Text('赚',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0)))),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: this
                                              ._toString(this.item["rebate"]),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2),
                                      TextSpan(
                                          text: '元/次',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1)
                                    ]),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                          width: 80,
                                          height: 10,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: LinearProgressIndicator(
                                                backgroundColor: Color.fromRGBO(
                                                    251, 128, 128, 1),
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Color.fromRGBO(
                                                            255, 31, 57, 1)),
                                                value: 0.2,
                                              ))),
                                      Container(
                                        child: Text('60%',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white)),
                                        width: 80,
                                        height: 10,
                                        alignment: Alignment.center,
                                      )
                                    ],
                                  ),
                                  Text('正在参团', style: TextStyle(fontSize: 9))
                                ],
                              ),
                            ],
                          )),
                          // Expanded(
                          Container(
                              height: 30,
                              width: 75,
                              child: RaisedButton(
                                color: Color.fromRGBO(255, 31, 57, 1),
                                child: Center(
                                  child: Text('立即拼团',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Color.fromRGBO(
                                              255, 255, 255, 1))),
                                ),
                                onPressed: () {},
                              )),
                        ],
                      ),
                    ],
                  )),
            )
          ],
        ));
  }
}
