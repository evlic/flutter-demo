import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MonkeyApp extends StatefulWidget {
  const MonkeyApp({Key? key}) : super(key: key);

  @override
  State<MonkeyApp> createState() => _MonkeyAppState();
}

class ColorRs {
  static const Color defTextColor = Colors.white;
  static const Color peachColor = Color(0xffcc828c);
  static const Color backGround = Colors.black;
}

class Texts {
  static TextStyle monkeyTextStyle =
      TextStyle(fontSize: 50.sp, color: ColorRs.defTextColor);
  static TextStyle titleTextStyle =
      TextStyle(fontSize: 100.sp, color: ColorRs.defTextColor);
  static TextStyle peachTextStyle =
      TextStyle(fontSize: 60.sp, color: ColorRs.peachColor);
}

class _MonkeyAppState extends State<MonkeyApp> {
  static int peachCnt = 0;
  static bool isGame = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "猴子找桃子",
          style: Texts.monkeyTextStyle,
        ),
      ),
      backgroundColor: ColorRs.backGround,
      // body: MaterialPageRoute(builder: (BuildContext context) {  return buildApp()}),
      body: buildApp(),
    );
  }

  // 分流构建 app 主界面
  Widget buildApp() {
    return isGame ? buildGame() : buildDashboard();
  }

  //  构建得分表
  Widget buildDashboard() {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Text("猴子🐒恰桃数: ",style: Texts.monkeyTextStyle),
            Text(peachCnt.toString(), style: Texts.monkeyTextStyle),
          ],
        ),
        Expanded(
          child: Center(
            child: Text("", style: Texts.titleTextStyle),
          ),
        )
      ],
    );
  }

  // 构建游戏就免
  Widget buildGame() {
    return widget;
  }
}
