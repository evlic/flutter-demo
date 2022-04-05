import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameScoreBoard extends StatelessWidget {
  const GameScoreBoard(
      {Key? key,
      this.img,
      required this.nowScore,
      required this.highestScore,
      this.child,
      required this.blurColor})
      : super(key: key);
  final Image? img;
  final int nowScore;
  final int highestScore;
  final Widget? child;
  final Color blurColor;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(padding: EdgeInsets.all(10), child: img),
        BlurW(
          color: blurColor,
          child:
              // 最顶层是文字
              gameStatus(),
        ),
        // gameStatus(),
      ],
    );
  }

  Container gameStatus() {
    return Container(
      width: 1080.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("当前得分"),
              Text(nowScore.toString()),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("历史最高得分"),
              Text(highestScore.toString()),
            ],
          ),
        ],
      ),
      // 背景图片
    );
  }
}

class BlurW extends StatelessWidget {
  final child;
  final color;

  const BlurW({
    this.child,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: Container(
          color: color,
          padding: EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}
