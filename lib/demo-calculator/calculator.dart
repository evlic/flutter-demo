// ignore_for_file: deprecated_member_use, constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);
  static const NKeys = [
    "AC", "∫", "%", "÷", //
    "7", "8", "9", "✕", //
    "4", "5", "6", "-", //
    "1", "2", "3", "+", //
    "0", " ", ".", "=", //
  ];

  static const TopKeys = ["AC", "∫", "%"];
  static const OptKeys = ["÷", "✕", "-", "+", "="];

  //按钮背景颜色
  static const Color NUM_BTN_BG = Color(0xff323232);
  //页面背景颜色
  static const Color PAGE_COLOR = Colors.black;
  //顶部按钮颜色
  static const Color TOP_BTN_BG = Color(0xFFa6a6a6);
  //右侧按钮颜色
  static const Color OPT_BTN_BG = Color(0xFFff9500);

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
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              // 自适应填充
              const Expanded(
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "显示区域",
                            style:
                                TextStyle(fontSize: 40.0, color: Colors.white),
                          )))),
              Center(child: _buildBtn()),
            ],
          ),
        ));
  }

  // 创建计算器单个按钮
  Widget buildButton(String val, {int flex = 1, Color color = NUM_BTN_BG}) {
    //
    return Expanded(
        flex: flex,
        child: RaisedButton(
          onPressed: null,
          child: Container(
            height: 120,
            padding: const EdgeInsets.all(0.0),
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: color,
              shape: flex > 1 ? BoxShape.rectangle : BoxShape.circle,
              borderRadius: flex > 1
                  ? const BorderRadius.all(Radius.circular(100.0))
                  : null,
            ),
            child: Center(
                child: Text(
              val,
              maxLines: 1,
              style: const TextStyle(fontSize: 30, color: Colors.white),
            )),
          ),
        ));
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
      // log("add i " + i.toString());
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

    log(rows.length.toString());

    return Column(
      children: rows,
    );
  }
}
