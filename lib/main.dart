import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'demo-address-book-local/address_home.dart';
import 'demo-address-book/app.dart';

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
        home: const AbHomeLocal("Go 通讯录"),
        // 取消 debug 标志
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
