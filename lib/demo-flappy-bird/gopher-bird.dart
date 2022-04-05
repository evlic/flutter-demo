import 'dart:async';
import 'dart:math';
import 'bird.dart';
import 'score-board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlappyBird extends StatefulWidget {
  const FlappyBird({Key? key}) : super(key: key);
  @override
  State<FlappyBird> createState() => _FlappyBirdState();
}

class _Asset {
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
  static late Image landGopherUnicorn = Image.asset(
    "$_assetImg/gopher_unicorn.$_gopherSuffix",
    fit: BoxFit.cover,
  );
}

class _Colors {
  static const background = Colors.black;
  static const defText = Colors.white;
  static const defBlur = Color(0x01f0f0f0);
  // 默认的管道颜色
  static const defPipe = Colors.blueAccent;

  // static const Background = Colors.black;
}

class _Text {
  static TextStyle RunningText = TextStyle(
    fontSize: 100.sp,
    color: _Colors.defText,
  );
  // static const Background = Colors.black;

}

class _Size {
  static double bird_h = 200.h;
  static double bird_w = 200.w;

  static double all_h = 1080.w;
  static double all_w = 1080.w;

  static double pip_w = 200.w;
  // 中空的间隔
  static double pip_spacing = 100.h;

  // 柱间间隔
  static double spacing = 0.2;
}

class _FlappyBirdState extends State<FlappyBird> {
  // 高度 上升为负，下降为正
  var _birdY = 0.1;
  var _isRuning = false;
  var _gameStatus_histroy = 100;
  var _gameStatus_now = 0;
  var r = Random();

  List<Widget> _gameArea = <Widget>[];
  // List<double> _pipesX = [];
  var x1 = 0.0, x2 = 0.4;

  // 定时器
  late Timer timer;
  onJumpEnd() {
    setState(() {
      _birdY = 1.05;
    });
  }

  jumpBird() {
    Fluttertoast.showToast(
        msg: "fly Bird",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.0);
    setState(() {
      if (_birdY >= -0.5) {
        _birdY -= 0.5;
      } else {
        _birdY = -1;
      }
    });
  }

  startGame() {
    setState(() {
      _isRuning = true;
      _gameStatus_now = 0;
      // _birdY = 1;
    });
    initPipe();
  }

  initPipe() {
    buildGameArea();
    // 初始化 pipes
    // 计算 pipe 数量
    // for (var i = 0; i < 1 / _Size.spacing; i++) {
    // for (var i = 0; i < 2; i++) {
    //   _pipesX.add(0.4 + i * _Size.spacing);
    //   _pipes.add(buildPipe(
    //     color: _Colors.defPipe,
    //     width: _Size.pip_w,
    //     spacing: _Size.pip_spacing,
    //     idx: i,
    //   ));
    // }
    // _gameArea.add(buildPipe(
    //   color: _Colors.defPipe,
    //   width: _Size.pip_w,
    //   spacing: _Size.pip_spacing,
    //   x: x1,
    // ));

    // _gameArea.add(buildPipe(
    //   color: _Colors.defPipe,
    //   width: _Size.pip_w,
    //   spacing: _Size.pip_spacing,
    //   x: x2,
    // ));

    // print("init len >> ${_pipes.length}");

    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      // print("更新 ${_pipesX.toString()}");
      // for (var i = 0; i < _pipesX.length; i++) {
      //   if (_pipesX[i] < -1.1) {
      //     _pipesX[i] = 0;
      //     _pipes[i] = buildPipe(
      //       color: _Colors.defPipe,
      //       width: _Size.pip_w,
      //       spacing: _Size.pip_spacing,
      //       idx: i,
      //     );
      //   } else {
      //     _pipesX[i] -= 0.02;
      //   }
      // }

      x1 -= 0.02;
      x2 -= 0.02;
      setState(() {});
    });
  }

  double randomRate() {
    return r.nextDouble();
  }

  Widget buildPipe(
      {required Color color,
      required double width,
      double? topRate,
      required double spacing,
      required double x}) {
    topRate ??= randomRate();
    // print("$idx >> ${_pipesX[idx]}");
    return Container(
      width: 1080.w,
      alignment: Alignment(x, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width,
            height: topRate * (1080.h - spacing),
            color: _Colors.defPipe,
          ),
          Container(
            width: width,
            height: (1 - topRate) * (1080.h - spacing),
            color: color,
          ),
        ],
      ),
    );
  }

  List<Widget> buildGameArea() {
    for (var i = 0; i < 1 / _Size.spacing; i++) {
      // for (var i = 0; i < 2; i++) {
      _gameArea.add(buildPipe(
        color: _Colors.defPipe,
        width: _Size.pip_w,
        spacing: _Size.pip_spacing,
        x: x1,
      ));
    }
    _gameArea.add(Bird(
      birdY: _birdY,
      onEnd: onJumpEnd,
      icon: _Asset.spaceGirlGohper,
    ));
    return _gameArea;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("evlic@Flappy Bird"),
      ),
      body: _isRuning
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
                            // _gameArea.map((e) => e).toList()
                            _gameArea[0], _gameArea[1], _gameArea[2],
                            _gameArea[3], _gameArea[4], _gameArea[5],
                          ],
                        ),
                      ),
                    ),
                  ),

                  // dashBoard
                  Expanded(
                    flex: 1,
                    child: GameScoreBoard(
                      blurColor: _Colors.defBlur,
                      highestScore: _gameStatus_histroy,
                      nowScore: _gameStatus_now,
                      img: _Asset.landGopherUnicorn,
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
      child: Text("点击开始游戏", style: _Text.RunningText),
    );
  }
}
