import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_app/public.dart';

GlobalKey<_TimerRunState> timerRunKey = GlobalKey();

// ignore: must_be_immutable
class TimerRun extends StatefulWidget {
  var endTime;
  var timeEndEvent;
  var item;
  TimerRun({Key key, this.timeEndEvent, this.item}) : super(key: key);

  @override
  _TimerRunState createState() => _TimerRunState(this.timeEndEvent, this.item);
}

class _TimerRunState extends State<TimerRun> {
  var timeEndEvent;
  var item;
  Timer _timer;
  Duration period = const Duration(milliseconds: 10);
  int seconds = 0;
  int time = 0;

  _TimerRunState(this.timeEndEvent, this.item);

  @override
  void initState() {
    super.initState();
  }

  void play() {
    print(["play"]);
    _timer = Timer.periodic(period, (timer) {
      setState(() {
        time += 10;
      });
    });
  }

  void pause() {
    print(["pause"]);
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  void reset() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    this.setState(() {
      time = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: constructTime(),
    );
  }

  Widget maohao() {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Text(':', style: text_1),
    );
  }

  Widget timeN(time) {
    return Container(
      width: 30.0,
      height: 30.0,
      alignment: Alignment.center,
      child: Text(time.toString().padLeft(2, "0"), style: text_1),
    );
  }

  Widget timeM(String time) {
    String t = time.length > 2
        ? time.substring(0, 2)
        : time.length == 1 ? time.padLeft(2, "0") : time;
    return Container(
      width: 30.0,
      height: 30.0,
      alignment: Alignment.center,
      child: Text(t, style: text_1),
    );
  }

  //时间格式化，根据总秒数转换为对应的 mm:ss:MM 格式
  Widget constructTime() {
    int millisecond = time % 1000;
    int second = time ~/ 1000 % 60;
    int minute = time ~/ 1000 ~/ 60 % 60;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        timeN(minute),
        maohao(),
        timeN(second),
        maohao(),
        timeM(millisecond.toString()),
      ],
    );
  }

  //数字格式化，将 0~9 的时间转换为 00~09
  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum;
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
  }
}

final TextStyle text_1 = TextStyle(fontSize: 22, color: Colors.white);
