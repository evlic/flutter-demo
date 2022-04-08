import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'bird.dart';
import 'score-board.dart';
import 'size.dart';

class FlappyBird extends StatefulWidget {
  const FlappyBird({Key? key}) : super(key: key);
  @override
  State<FlappyBird> createState() => _FlappyBirdState();
}

class Assets {
  static const _eCLoudURL =
      "https://pub.evlic.cloud/coding/flutter-game/flappy-bird";
  // 默认文件后缀
  static const _assetImg = "assets/img";

  static const _defSuffix = "jpg";
  static const _gopherSuffix = "png";

  static late Image houZonBQB = Image.network("$_eCLoudURL/hjl.$_defSuffix");
  static late Image gotGohper =
      Image.network("$_eCLoudURL/GOT_Gopher.$_gopherSuffix");
  static late Image spaceGirlGohper =
      Image.network("$_eCLoudURL/SPACEGIRL_GOPHER.$_gopherSuffix");

  // 背景图片
  // 独角兽
  static late Image aLandGopherUnicorn = Image.asset(
    "$_assetImg/gopher_unicorn.$_gopherSuffix",
    fit: BoxFit.cover,
  );

  static late Image aSpaceGirlGohper = Image.asset(
    "$_assetImg/space_gopher.$_gopherSuffix",
    fit: BoxFit.cover,
  );
}

class DefColors {
  static const background = Colors.black;
  static const defText = Colors.white;
  static const defBlur = Color(0x01f0f0f0);
  // 默认的管道颜色
  static const defPipe = Colors.blueAccent;

  // static const Background = Colors.black;
}

class Texts {
  static TextStyle RunningText = TextStyle(
    fontSize: 100.sp,
    color: DefColors.defText,
  );
  // static const Background = Colors.black;

}

class _FlappyBirdState extends State<FlappyBird> {
  // 高度 上升为负，下降为正
  var _birdY = 0.1;
  var _isRunning = false;

  var _maxScore = 100;
  var _nowScore = 0;
  var r = Random();

  // 最大 pipe 数量
  static const maxPipe = 5;
  // 起点
  static const startPipe = 0.8;
  var pipeColor = DefColors.defPipe;
  var pipBorder = BoxDecoration(
      color: DefColors.defPipe,
      // Red border with the width is equal to 5
      border: Border.all(width: 5, color: Colors.red));
  late List<double> pipeX;
  late List<double> topRate;

  // 定时器
  late Timer timer;

  onJumpEnd() {
    setState(() {
      _birdY = 1.05;
    });
  }

  logShow(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black45,
      textColor: DefColors.defText,
      fontSize: 16.0,
    );
  }

  // 跳
  jumpBird() {
    logShow("fly!");
    setState(() {
      if (_birdY >= -0.5) {
        _birdY -= 0.5;
      } else {
        _birdY = -1;
      }
    });
  }

  // 开始游戏
  startGame() {
    _isRunning = true;
    _nowScore = 0;

    pipeX = List.generate(
        maxPipe, (i) => startPipe + i * (Sizes.pip + Sizes.spacing));
    topRate = List.generate(maxPipe, (i) => randomRate());

    setState(() {});

    _birdY = 1;
    init();
  }

  // 初始化 pipe 需要的参数
  // 并添加 定时任务
  init() {
    var maxX = 0.0;
    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      var maxX = 0.0;
      for (var v in pipeX) {
        maxX = max(maxX, v);
      }
      for (var i = 0; i < maxPipe; i++) {
        if (pipeX[i] < -1 - Sizes.pip) {
          logShow(
              "「$i」到达左边界，${pipeX[i]}\n转移到 >> ${max(1.0 + Sizes.pip, maxX + Sizes.spacing)}");
          pipeX[i] = max(1.0 + Sizes.pip, maxX + Sizes.spacing);
          topRate[i] = randomRate();
        } else {
          pipeX[i] -= 0.02;
        }
      }
      setState(() {});
    });
  }

  double randomRate() {
    return r.nextDouble();
  }

  Widget buildPipe({
    Color color = DefColors.defPipe,
    required double width,
    double? topRate,
    required double spacing,
    required double x,
  }) {
    topRate ??= randomRate();

    return Container(
      width: 1080.w,
      alignment: Alignment(x, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width,
            height: topRate * (1080.h - spacing),
            decoration: pipBorder,
          ),
          Container(
            width: width,
            height: (1 - topRate) * (1080.h - spacing),
            decoration: pipBorder,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("evlic@Flappy Bird"),
      ),
      body: _isRunning
          ? Container(
              width: 1080.w,
              height: 2340.h,
              child: Column(
                children: [
                  // 操作区
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      // 设置点击事件穿过空区域
                      behavior: HitTestBehavior.opaque,
                      onTap: jumpBird,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        // width: 1080.w,
                        // height: 1080.h,
                        // 点击小鸟上升 50% 屏幕高度
                        // alignment: Alignment(0.75, _birdY),

                        // 游戏画面
                        child: Stack(
                          children: [
                            buildPipe(
                              color: pipeColor,
                              width: Sizes.pipW,
                              spacing: Sizes.pipSpacingH,
                              x: pipeX[0],
                              topRate: topRate[0],
                            ),
                            buildPipe(
                              color: DefColors.defPipe,
                              width: Sizes.pipW,
                              spacing: Sizes.pipSpacingH,
                              x: pipeX[1],
                              topRate: topRate[1],
                            ),
                            buildPipe(
                              color: DefColors.defPipe,
                              width: Sizes.pipW,
                              spacing: Sizes.pipSpacingH,
                              x: pipeX[2],
                              topRate: topRate[2],
                            ),
                            buildPipe(
                              color: DefColors.defPipe,
                              width: Sizes.pipW,
                              spacing: Sizes.pipSpacingH,
                              x: pipeX[3],
                              topRate: topRate[3],
                            ),
                            buildPipe(
                              color: DefColors.defPipe,
                              width: Sizes.pipW,
                              spacing: Sizes.pipSpacingH,
                              x: pipeX[4],
                              topRate: topRate[4],
                            ),
                            Bird(
                              birdY: _birdY,
                              birdImg: Assets.aSpaceGirlGohper,
                              onEnd: onJumpEnd,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  // dashBoard
                  Expanded(
                    flex: 1,
                    child: GameScoreBoard(
                      blurColor: DefColors.defBlur,
                      highestScore: _maxScore,
                      nowScore: _nowScore,
                      img: Assets.aLandGopherUnicorn,
                    ),
                  )
                ],
              ),
            )
          : GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: startGame,
              child: const WelcomeText()),
    );
  }
}

/* class Pipe extends StatelessWidget {
  static Random r = Random();
  final Color color;
  final double width;
  double? topRate;
  final double spacing;
  double x;
  Pipe({
    Key? key,
    required this.color,
    required this.width,
    required this.spacing,
    required this.x,
    //
    this.topRate,
  }) : super(key: key);

  double rate() {
    topRate ??= r.nextDouble();
    return topRate!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment(x, 0),
          child: Container(
            width: width,
            height: rate() * (1080.h - spacing),
            color: _Colors.defPipe,
          ),
        ),
        Container(
          alignment: Alignment(x, 0),
          child: Container(
            width: width,
            height: (1 - rate()) * (1080.h - spacing),
            color: color,
          ),
        ),
      ],
    );
  }
}
 */

// 开始提示
class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("点击开始游戏", style: Texts.RunningText),
    );
  }
}
