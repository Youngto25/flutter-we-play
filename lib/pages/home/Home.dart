import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/AppBarX.dart';
import 'package:flutter_app/pages/home/PhotoViewPage.dart';
import 'package:flutter_app/pages/home/component/PintuanItem.dart';
import '../../utils/http/request.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

const String server = "https://cdn.shibe.online/shibes/";
const String api = "http://shibe.online/api";

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
        if (!theEnd) {
          // loadMoreData();
        }
      } else {}
    });
  }

  @override
  void initState() {
    super.initState();
    this.getList();
  }

  void getList() async {
    // var response = await HttpManage.request(
    //     'shibes', {"count": 5, "urls": false, "httpsUrls": true}, 'get',
    //     server: api);
    var response = [
      "6f727f009983cc06f16b8b14c1e22c1a9f7b5038",
      "aee6c1fb1508fb7a999cfe336f84fb508c572660",
      "49659e3845d17dcc756259e2bbebe42c3b9b701b",
      "3c9ec2bcdf532cea1f3165479c8bf6f8eb83f38a",
      "7f8370b6ccdb0041ed28fd686a5953622076c18f"
    ];
    String string = response.toString();
    String str = string
        .substring(1, string.length - 1)
        .replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    List list = str.split(",");
    List arr = [];
    list.forEach((vo) {
      arr.add("$server$vo.jpg");
    });
    _list = [..._list, ...arr];
    this.setState(() {});
  }

  Future refresh() async {
    debugPrint("onRefresh");
    currentPage = 1;
    theEnd = false;
    _list = [];
    getList();
  }

  Future load() async {
    debugPrint("onload");
    getList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBarX(title: "Picture"),
        body: _list.length == 0
            ? Center(child: CircularProgressIndicator())
            : EasyRefresh(
                header: ClassicalHeader(
                  refreshText: "刷新",
                  refreshReadyText: "haole",
                ),
                onRefresh: () async {
                  await refresh();
                },
                onLoad: () async {
                  await load();
                },
                child: ListView.builder(
                    controller: _controller,
                    padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                    itemCount: this._list.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          color: Colors.white,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(new FadeRoute(
                                    page: PhotoViewGalleryScreen(
                                  images: _list, //传入图片list
                                  index: index, //传入当前点击的图片的index
                                  heroTag:
                                      _list[index], //传入当前点击的图片的hero tag （可选）
                                )));
                              },
                              child: getImage(index: index)));
                    })));
  }

  Widget getImage({index}) {
    // Image image = Image.network(_list[index]);

    // image.image
    //     .resolve(new ImageConfiguration())
    //     .addListener(new ImageStreamListener(
    //   (ImageInfo info, bool _) {
    //     print('model.width======${info.image.width},${info.image.height}');
    //   },
    // ));

    return Image.network(
      _list[index],
      frameBuilder: (context, child, frame, wasSynchronousLoaded) {
        if (wasSynchronousLoaded) {
          return child;
        } else {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: frame != null
                ? child
                : SizedBox(
                    width: double.infinity,
                    height: 300.0,
                  ),
          );
        }
      },
    );
  }

  bool get wantKeepAlive => true;
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
