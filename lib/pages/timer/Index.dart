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
  List<IconData> icon = [Icons.play_arrow, Icons.pause];
  AnimationController controller;
  Animation<double> animation;

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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xffffffff),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        this.setState(() {
                          isPlay = !isPlay;
                        });
                        timeChange();
                      },
                      child: Icon(!isPlay ? Icons.play_arrow : Icons.pause,
                          size: 48.0, color: Color(0xff34495e))),
                  GestureDetector(
                      onTap: () {
                        this.setState(() {
                          isPlay = false;
                        });
                        timerRunKey.currentState.reset();
                        animatePause();
                      },
                      child: Icon(Icons.restore,
                          size: 48.0, color: Color(0xff34495e))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
