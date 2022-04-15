import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 提供默认的 toast, 输出 msg, 并且其持续时间为 int 300 毫秒
logMsg({required String msg, int time = 300}) async {
  print(msg);
  Fluttertoast.showToast(
      msg: msg,
      toastLength: time > 1000 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white12,
      textColor: Colors.white,
      fontSize: 50.sp
  );
  Timer(Duration(milliseconds: time), () => {Fluttertoast.cancel()});
}