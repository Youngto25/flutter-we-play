import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/TimerRun.dart';
import 'package:flutter_app/public.dart';

class TheTimer extends StatefulWidget {
  TheTimer({Key key}) : super(key: key);

  @override
  _TheTimerState createState() => _TheTimerState();
}

class _TheTimerState extends State<TheTimer>
    with SingleTickerProviderStateMixin {
  bool isPlay = false;
  bool isSave = false;
  List<IconData> icon = [Icons.play_arrow, Icons.pause];
  AnimationController controller;
  Animation<double> animation;
  String currentAction = "平板支撑";

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
        title: "计时器",
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Color(0xffffffff),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(currentAction, style: TextStyle(fontSize: 24)),
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
              ],
            ),
          ),
          Positioned(
              right: 20,
              bottom: 180,
              child: FloatingActionButton(
                child: Icon(!isPlay ? Icons.play_arrow : Icons.pause),
                backgroundColor: Color.fromRGBO(255, 50, 50, 1),
                onPressed: () {
                  this.setState(() {
                    isPlay = !isPlay;
                  });
                  timeChange();
                },
              )),
          Positioned(
              right: 20,
              bottom: 100,
              child: FloatingActionButton(
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
                  key: ValueKey(isSave),
                  child: Icon(isSave ? Icons.check : Icons.save),
                  backgroundColor: Color.fromRGBO(255, 50, 50, 1),
                  onPressed: () {
                    int time = timerRunKey.currentState.time;
                    print(["save time===>", time]);

                    Action action = new Action(currentAction, time);

                    print(["action===>", action.toString()]);

                    if (time < 1000) {
                      return;
                    }
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

class Action {
  String action = "";
  int duration = 0;

  Action(this.action, this.duration);

  String getAcition() {
    return this.action;
  }

  int getDuration() {
    return this.duration;
  }

  String toString() {
    return "action:" + this.action + ",duration:" + this.duration.toString();
  }
}
