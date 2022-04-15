import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ComColors {
  // 背景颜色
  static const backGroundColor = Colors.white;
  // card 背景颜色
  static const Color card = Color.fromARGB(0xff, 242, 242, 242);
  // 默认字体颜色
  static const Color def = Color.fromARGB(0xff, 26, 26, 26);
  // sub 子字体颜色
  static const Color sub = Color.fromARGB(0xff, 153, 153, 153);
  // elm 蓝色
  static const Color elmBlue = Color.fromARGB(0xff, 1, 182, 253);
}

class ComTextStyle {
  // 店铺信息字体格式
  static TextStyle trade = TextStyle(
    color: ComColors.def,
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
  );

  // 商品标题 title
  static TextStyle title = TextStyle(
    color: ComColors.def,
    fontSize: 36.sp,
    fontWeight: FontWeight.w600,
  );

  // 商品选项
  static TextStyle subTitle = TextStyle(
      color: ComColors.sub, fontSize: 30.sp, fontWeight: FontWeight.normal);

  // 商品价格
  static TextStyle price = TextStyle(
      color: ComColors.elmBlue, fontSize: 36.sp, fontWeight: FontWeight.w600);

  // 商品数量
  static TextStyle num = TextStyle(
      color: ComColors.sub, fontSize: 28.sp, fontWeight: FontWeight.w600);

  // 商品总价
  static TextStyle cost = TextStyle(
      color: ComColors.elmBlue, fontSize: 36.sp, fontWeight: FontWeight.w600);

// static const TextStyle smallSize = TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal);
}
