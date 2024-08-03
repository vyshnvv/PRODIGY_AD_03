import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/provider/timer_provider.dart';
import 'package:stopwatch/screens/timer_screen.dart';
import 'package:stopwatch/utils/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: TextTheme(bodyMedium: TextStyle(color: bgColor))),
      home: ChangeNotifierProvider<TimerProvider>(
        create: (context) => TimerProvider(),
        child: TimerScreen(),
      ),
    );
  }
}
