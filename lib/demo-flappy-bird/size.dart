import 'package:flutter_screenutil/flutter_screenutil.dart';

class Sizes {
  // bird 的尺寸
  static double birdH = 200.sp;
  static double birdW = 200.sp;

  // 游戏显示区总尺寸
  static double gameH = 1080.h;
  static double gameW = 1080.w;

  // 管道宽度
  static double pipW = 150.w;
  static double pip = 2 * pipW / gameW;

  // 两柱中空的间隔
  static double pipSpacingH = 100.h;

  // 柱间间隔
  static double spacingW = 200.w;
  static double spacing = 2 * spacingW / gameW;
}
