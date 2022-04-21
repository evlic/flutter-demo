import 'package:flutter/material.dart';
import 'demo-elm/app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



// runApp(const MusicPlayer());
void main() => runApp(const IdxApp());

class IdxApp extends StatelessWidget {
  const IdxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // 自适应屏幕尺寸
      designSize: const Size(1080, 2340),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context) => MaterialApp(
        title: "evlic@Flutter Demo",
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        // theme: ThemeData.dark(),
        // theme: ThemeData.dark(),
        // home: const CalculatorApp(),
        // home: const LoginFormApp(),
        home: const ElmApp(),
        // 取消 debug 标志
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
