import 'package:flutter/material.dart';
import 'package:stopwatch/utils/colors.dart';

class LapContainer extends StatelessWidget {
  final index, h, m, s;
  final void Function() deleteLap;
  const LapContainer(
      {super.key,
      required this.index,
      required this.h,
      required this.m,
      required this.s,
      required this.deleteLap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(12),
      decoration:
          BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(5)),
      child: Row(children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(10)),
          child: Text(
            textAlign: TextAlign.center,
            "$index",
            style: TextStyle(
                color: bgColor,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.05),
          ),
        ),
        SizedBox(
          width: size.width * 0.04,
        ),
        Text(
          "${h.toString().padLeft(2, '0')}:",
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: size.width * 0.075,
          ),
        ),
        Text(
          "${m.toString().padLeft(2, '0')}:",
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: size.width * 0.075,
          ),
        ),
        Text(
          s.toString().padLeft(2, '0'),
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: size.width * 0.075,
          ),
        ),
        SizedBox(
          width: size.width * 0.09,
        ),
        ElevatedButton.icon(
          onPressed: deleteLap,
          label: Icon(Icons.delete),
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: secondaryColor,
              padding: EdgeInsets.all(10),
              shape: CircleBorder()),
        )
      ]),
    );
  }
}
