import 'package:flutter/material.dart';
import 'size.dart';

class Bird extends StatelessWidget {
  const Bird({
    Key? key,
    required this.birdY,
    this.onEnd,
    required this.birdImg,
  }) : super(key: key);

  final double birdY;
  final Function? onEnd;
  final Image birdImg;
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
      child: SizedBox(
        width: Sizes.birdW,
        height: Sizes.birdH,
        // padding: EdgeInsets.all(10.sp),
        // child: _Asset.spaceGirlGohper,
        child: birdImg,
      ),
    );
  }
}
