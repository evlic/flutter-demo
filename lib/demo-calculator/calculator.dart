// ignore_for_file: deprecated_member_use, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CalculatorState();
}

class CalculatorState extends State<CalculatorApp> {
  //按钮背景颜色
  static const Color NUM_BTN_BG = Color(0xff323232);
  //页面背景颜色
  static const Color PAGE_COLOR = Colors.black;
  //顶部按钮颜色
  static const Color TOP_BTN_BG = Color(0xFFa6a6a6);
  //右侧按钮颜色
  static const Color OPT_BTN_BG = Color(0xFFff9500);

  static const NKeys = [
    "AC", "∫", "%", "÷", //
    "7", "8", "9", "✕", //
    "4", "5", "6", "-", //
    "1", "2", "3", "+", //
    "0", " ", ".", "=", //
  ];

  static const TopKeys = ["AC", "∫", "%"];
  static const OptKeys = ["÷", "✕", "-", "+", "="];
  static const OptShape = CircleBorder(
    side: BorderSide(
        // width: 2,
        // color: Colors.red,
        // style: BorderStyle.solid,
        // style: BorderStyle.none,
        ),
  );

  static const WiderShape = StadiumBorder(
    side: BorderSide(
        // width: 2,
        // color: Colors.red,
        // style: BorderStyle.solid,
        // style: BorderStyle.none,
        ),
  );

  var W = "";
  // APP 主体
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_COLOR,
      appBar: AppBar(
        title: const Text("计算器"),
        // 设置居中
        centerTitle: true,
        backgroundColor: PAGE_COLOR,
      ),
      // ignore: avoid_unnecessary_containers
      // 给操作区添加 padding 和屏幕隔开边距
      body: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Column(
          children: <Widget>[
            // 自适应填充
            Expanded(child: _buildDisplay()),
            Center(child: _buildBtn()),
          ],
        ),
      ),
    );
  }

  // 显示区域
  Widget _buildDisplay() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        child: Align(
          // 右下角
          alignment: Alignment.bottomRight,
          child: Text(
            W,
            style: TextStyle(fontSize: 40.0, color: Colors.white),
          ),
        ),
      ),
    );
  }

  int calculate(String s) {
    var stack = <int>[];
    return 1;
  }

  opt(key) => (key) {};

  void doPress(String key) {
    switch (key) {
      case "AC":
        {
          W = "";
        }
        break;
      case "∫":
        {
          W = "求导还没做";
        }
        break;
      case "=":
        {
          W += calculate(W).toString();
        }
        break;
      default:
        W += key;
    }
    // 更新 state
    setState(() {});
  }

  // 创建计算器单个按钮
  Widget buildButton(String val, {int flex = 1, Color color = NUM_BTN_BG}) {
    //
    return Expanded(
      flex: flex,
      child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: RaisedButton(
            color: color,
            textColor: Colors.white,
            shape: flex == 1 ? OptShape : WiderShape,
            onPressed: () {
              doPress(val);
            },
            child: SizedBox(
              height: 240.sp,
              width: flex * 240.sp,
              child: Center(
                  child: Text(
                val,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 90.sp,
                ),
              )),
            ),
          )),
    );
  }

  // 创建计算器按钮组
  Widget _buildBtn() {
    List<Widget> rows = [];

    List<Widget> btn = [];

    for (int i = 0; i < NKeys.length; i++) {
      var key = NKeys[i];
      if (key == " ") {
        continue;
      }
      btn.add(buildButton(key,
          // flex: ,
          color: TopKeys.contains(key)
              ? TOP_BTN_BG
              : OptKeys.contains(key)
                  ? OPT_BTN_BG
                  : NUM_BTN_BG,
          flex: i < NKeys.length - 1
              ? NKeys[i + 1] == " "
                  ? 2
                  : 1
              : 1));
      if ((i + 1) % 4 == 0) {
        rows.add(Row(
          children: btn,
        ));
        btn = [];
      }
    }

    if (btn.isNotEmpty) {
      rows.add(Row(
        children: btn,
      ));
      btn = [];
    }
    return Column(
      children: rows,
    );
  }
}
