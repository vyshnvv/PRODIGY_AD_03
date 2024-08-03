import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/provider/timer_provider.dart';
import 'package:stopwatch/utils/colors.dart';
import 'package:stopwatch/widgets/lap_container.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  var timer;
  late final AnimationController _animcontroller1;
  late final AnimationController _animcontroller2;
  late final AnimationController _animcontroller3;
  late final AnimationController _animcontroller4;
  @override
  void initState() {
    super.initState();
    timer = Provider.of<TimerProvider>(context, listen: false);
    _animcontroller1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animcontroller2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _animcontroller3 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animcontroller4 =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  void lapIt() {
    var h = timer.hrs;
    var m = timer.mins;
    var s = timer.secs;
    (timer.isRunning) ? laps.add([h, m, s]) : "";
  }

  void deleteLap(int index) {
    setState(() {
      laps.removeAt(index);
    });
  }

  var laps = [];

  @override
  void dispose() {
    _animcontroller1.dispose();
    _animcontroller2.dispose();
    _animcontroller3.dispose();
    _animcontroller4.dispose();
    timer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(body:
          Consumer<TimerProvider>(builder: (context, timeprovider, widget) {
        return Column(
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(10)),
              child: Text(
                "${timer.hrs.toString().padLeft(2, '0')} : ${timer.mins.toString().padLeft(2, '0')} : ${timer.secs.toString().padLeft(2, '0')} : ${timer.ms.toString().padLeft(3, '0')}",
                textScaler: TextScaler.linear(4.3),
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      minimumSize: Size(size.width * 0.3, size.height * 0.05)),
                  onPressed: () {
                    if (!timer.isRunning) {
                      timer.start();
                      _animcontroller1.reset();
                      _animcontroller1.forward();
                      _animcontroller3.repeat();
                      _animcontroller4.repeat();
                    } else {
                      timer.pause();
                      _animcontroller1.reverse();
                      _animcontroller4.stop();
                      _animcontroller3.stop();
                    }
                  },
                  label: ClipRect(
                    child: Align(
                      alignment: Alignment.center,
                      widthFactor: 0.5,
                      heightFactor: 0.2,
                      child: Lottie.asset(
                        "assets/animations/playpause.json",
                        controller: _animcontroller1,
                        width: size.width * 0.3,
                        height: size.height * 0.28,
                      ),
                    ),
                  ),
                ),
                ClipRect(
                  child: Align(
                    alignment: Alignment.center,
                    widthFactor: 0.15,
                    heightFactor: 0.135,
                    child: Transform.scale(
                      scale: size.width * 0.001,
                      child: Lottie.asset(
                        controller: _animcontroller4,
                        "assets/animations/running.json",
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    timer.reset();
                    _animcontroller2.forward();
                    _animcontroller1.reset();
                    _animcontroller4.reset();
                    _animcontroller3.reset();
                  },
                  label: ClipRect(
                    child: Align(
                      alignment: Alignment.center,
                      widthFactor: 0.8,
                      heightFactor: 0.4,
                      child: Lottie.asset("assets/animations/reset.json",
                          controller: _animcontroller2,
                          width: size.width * 0.1,
                          height: size.height * 0.1,
                          repeat: true,
                          frameRate: FrameRate(120),
                          reverse: false),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.all(10),
                      minimumSize: Size(size.width * 0.3, size.height * 0.05)),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              children: [
                Container(
                  width: size.width * 0.9,
                  height: size.height * 0.06,
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: ElevatedButton.icon(
                    onPressed: lapIt,
                    label: ClipRect(
                      child: Align(
                        alignment: Alignment.center,
                        widthFactor: 0.5,
                        heightFactor: 0.5,
                        child: Lottie.asset(
                          controller: _animcontroller3,
                          "assets/animations/lap.json",
                          width: size.width * 1,
                          height: size.height * 0.5,
                          repeat: true,
                          frameRate: FrameRate(120),
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        minimumSize:
                            Size(size.width * 0.3, size.height * 0.05)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            AnimatedContainer(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryColor,
              ),
              duration: Duration(milliseconds: 500),
              width: size.width * 0.9,
              height: size.height * 0.52,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (BuildContext context, int index) {
                    return (laps.isNotEmpty)
                        ? LapContainer(
                            index: index + 1,
                            h: laps[index][0],
                            m: laps[index][1],
                            s: laps[index][2],
                            deleteLap: () => deleteLap(index),
                          )
                        : null;
                  },
                ),
              ),
            )
          ],
        );
      })),
    );
  }
}
