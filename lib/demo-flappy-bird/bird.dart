import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bird extends StatelessWidget {
  const Bird({
    Key? key,
    required this.birdY,
    this.onEnd,
    required this.icon,
  }) : super(key: key);

  final double birdY;
  final Function? onEnd;
  final Image icon;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment(-0.80, birdY),
      // alignment: Alignment(-0.80, 0),
      // alignment: Alignment(0, 0),
      onEnd: () {
        onEnd?.call();
      },
      duration: const Duration(milliseconds: 500),
      child: Container(
        width: 200.w,
        height: 200.h,
        padding: EdgeInsets.all(10.sp),
        // child: _Asset.spaceGirlGohper,
        child: icon,
      ),
    );
  }
}
