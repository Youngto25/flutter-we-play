import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/TimerRun.dart';
import 'package:flutter_app/public.dart';

class TheTimer extends StatefulWidget {
  TheTimer({Key key}) : super(key: key);

  @override
  _TheTimerState createState() => _TheTimerState();
}

class _TheTimerState extends State<TheTimer>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool isPlay = false;
  bool isSave = false;
  List<IconData> icon = [Icons.play_arrow, Icons.pause];
  AnimationController controller;
  Animation<double> animation;
  String type = "平板支撑";
  List<Finish> finishList = [];
  FinishProvider finishProvider;
  int totalTime = 0;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    Animation<double> curve =
        CurvedAnimation(parent: controller, curve: Curves.easeOut);
    animation = Tween(begin: 1.0, end: 1.11).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
    this.initDatabase();
  }

  // 初始化数据库
  void initDatabase() async {
    finishProvider = new FinishProvider();
    await finishProvider.open();
    this.initFinishCount();
  }

  // 初始化数据
  void initFinishCount() async {
    finishList = await finishProvider.query(type);
    int total = 0;
    finishList.forEach((Finish vo) {
      print(["init===>", vo.getType(), vo.getId(), vo.getCount()]);
      total += vo.getCount();
    });
    totalTime = total;
    this.setState(() {});
    if (finishList.length == 0) {
      return;
    }
  }

  // 获取运动时长
  String getSportDuration(int m) {
    int minutes = m ~/ 1000 ~/ 60;
    int seconds = m ~/ 1000;
    int mills = (m % 1000 / 10).toInt();
    return minutes.toString().padLeft(2, "0") + ':' + seconds.toString().padLeft(2, "0") + ':' + mills.toString();
  }

  void animatePlay() {
    controller.repeat(reverse: true);
  }

  void animatePause() {
    controller.stop();
  }

  void timeChange() {
    if (isPlay) {
      timerRunKey.currentState.play();
      animatePlay();
    } else {
      timerRunKey.currentState.pause();
      animatePause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: "计时器->总完成时长" + DateUtil.getDurationTime(totalTime),
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(left: 10, right: 10),
            color: Color(0xffffffff),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(type, style: TextStyle(fontSize: 24)),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 200,
                      child: Transform.scale(
                          scale: animation.value,
                          child: Container(
                            alignment: Alignment.center,
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                                color: Color(0xff34495e).withOpacity(0.4),
                                borderRadius: BorderRadius.circular(100)),
                          )),
                    ),
                    Positioned(
                        child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                          color: Color(0xff34495e),
                          borderRadius: BorderRadius.circular(90)),
                      child: Center(
                        child: TimerRun(
                          key: timerRunKey,
                        ),
                      ),
                    ))
                  ],
                ),
                finishList.length > 0 ? Expanded(
                  flex: 1,
                  child: ListView(
                    padding: EdgeInsets.only(top: 10.0),
                    children: finishList.map<Widget>((Finish vo) {
                      return GestureDetector(
                        onLongPress: () {
                          showCupertinoModalPopup(
                              context: context,
                              // filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              builder: (BuildContext context) {
                                return CupertinoActionSheet(
                                  title: Text('提示'),
                                  message: Text('是否要删除当前项？'),
                                  actions: <Widget>[
                                    CupertinoActionSheetAction(
                                      child: Text('删除'),
                                      onPressed: () async {
                                        await finishProvider.delete(vo.getId());
                                        initFinishCount();
                                        Navigator.of(context).pop();
                                      },
                                      isDefaultAction: true,
                                    ),
                                    CupertinoActionSheetAction(
                                      child: Text('暂时不删'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      isDestructiveAction: true,
                                    ),
                                  ],
                                );
                              }
                          );
                        },
                        child: Container(
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
                                Container(
                                  width: 140.0,
                                  child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Text(getSportDuration(vo.getCount())),
                                        ),
                                        Text(
                                          DateUtil.getTimeDiff(DateTime.parse(
                                              vo.getCreatedTime())),
                                        )
                                      ]),
                                )
                              ],
                            )),
                      );
                    }).toList(),
                  ),
                ) : Container()
              ],
            ),
          ),
          Positioned(
              right: 20,
              bottom: 180,
              child: AnimatedSwitcher(
                  transitionBuilder: (child, anim) {
                    return ScaleTransition(
                      child: child,
                      scale: anim,
                    );
                  },
                  duration: Duration(milliseconds: 500),
                  child: FloatingActionButton(
                    heroTag: "startOrStop",
                    key: ValueKey(isPlay),
                    child: Icon(!isPlay ? Icons.play_arrow : Icons.pause),
                    backgroundColor: Color.fromRGBO(255, 50, 50, 1),
                    onPressed: () {
                      this.setState(() {
                        isPlay = !isPlay;
                      });
                      timeChange();
                    },
                  ))),
          Positioned(
              right: 20,
              bottom: 100,
              child: FloatingActionButton(
                heroTag: "refresh",
                child: Icon(Icons.restore),
                backgroundColor: Color.fromRGBO(255, 50, 50, 1),
                onPressed: () {
                  this.setState(() {
                    isPlay = false;
                  });
                  timerRunKey.currentState.reset();
                  animatePause();
                },
              )),
          Positioned(
              right: 20,
              bottom: 20,
              child: AnimatedSwitcher(
                transitionBuilder: (child, anim) {
                  return ScaleTransition(
                    child: child,
                    scale: anim,
                  );
                },
                duration: Duration(milliseconds: 500),
                child: FloatingActionButton(
                  heroTag: "save",
                  key: ValueKey(isSave),
                  child: Icon(isSave ? Icons.check : Icons.save),
                  backgroundColor: Color.fromRGBO(255, 50, 50, 1),
                  onPressed: () async {
                    int time = timerRunKey.currentState.time;
                    Finish action = new Finish(type, time, new DateTime.now().toString(), 0);
                    await finishProvider.insert(action);
                    this.initFinishCount();
                    this.setState(() {
                      isPlay = false;
                      isSave = true;
                    });
                    timerRunKey.currentState.reset();
                    animatePause();
                    Timer(Duration(milliseconds: 1000), () {
                      this.setState(() {
                        isSave = false;
                      });
                    });
                  },
                ),
              )),
        ],
      ),
    );
  }
}

