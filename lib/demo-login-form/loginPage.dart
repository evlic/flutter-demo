import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginFormApp extends StatefulWidget {
  const LoginFormApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class POJO {
  const POJO(this.label, this.inputA, this.inputB);
  final String label;
  final String inputA;
  final String inputB;
}

class _LoginState extends State<LoginFormApp> {
  static const PAGE_BACKGROUND_COLOR = Colors.black;
  static const LINK_COLOR = Color(0xff4a80d8);
  static const LABLE_COLOR = Colors.white60;
  static const DEF_FONT = Colors.white;

  static int idx = 0;

  static Map<int, POJO> map = {
    0: const POJO("请输入您的姓名", "姓氏", "名称"),
    1: const POJO("请自定义您的账户信息", "用户名", "密码"),
  };

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  POJO obj = map[idx] as POJO;

  Widget btnNext() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
            width: 54.sp * 4,
            height: 100.sp,
            child: ElevatedButton(
              onPressed: () {
                if (idx < map.length) {
                  idx++;
                  setState(() {
                    obj = map[idx] as POJO;
                  });
                } else {}
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(LINK_COLOR),
              ),
              child: Text(
                idx < map.length - 1 ? "下一步" : "提交",
                style: TextStyle(
                  color: PAGE_BACKGROUND_COLOR,
                  fontSize: 40.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget btnPrv() {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.all(10.sp),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: SizedBox(
          width: 54.sp * 4,
          height: 100.sp,
          child: ElevatedButton(
            onPressed: () {
              if (idx >= 0) {
                idx--;
                setState(() {
                  obj = map[idx] as POJO;
                });
              } else {}
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(LINK_COLOR),
            ),
            child: Text(
              "上一步",
              style: TextStyle(
                color: PAGE_BACKGROUND_COLOR,
                fontSize: 40.sp,
              ),
            ),
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Scaffold(
        backgroundColor: PAGE_BACKGROUND_COLOR,
        appBar: AppBar(
          title: Text(
            "Goolge",
            style: TextStyle(fontSize: 60.sp),
          ),
          // 设置居中
          centerTitle: true,
          backgroundColor: PAGE_BACKGROUND_COLOR,
        ),
        // ignore: avoid_unnecessary_containers
        // 给操作区添加 padding 和屏幕隔开边距
        body: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Text(
                        "创建 Google 账号",
                        style: TextStyle(fontSize: 64.sp, color: DEF_FONT),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Text(
                        obj.label,
                        style: TextStyle(fontSize: 48.sp, color: LABLE_COLOR),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Form(
                        //设置globalKey，用于后面获取FormState
                        key: loginKey,
                        //开启自动校验
                        // autovalidate: true,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: LABLE_COLOR),
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                // labelText: '',
                                hintText: obj.inputA,
                                hintStyle: TextStyle(
                                  color: LABLE_COLOR,
                                  fontSize: 50.sp,
                                ),
                                // prefixIcon: Icon(Icons.person),
                              ),
                              style: TextStyle(
                                color: DEF_FONT,
                                fontSize: 50.sp,
                              ),
                              //校验用户
                              // validator: (value) {
                              //   return value.trim().length > 0 ? null : "用户名不能为空";
                              // },
                              //当 Form 表单调用保存方法 Save时回调的函数。
                              // onSaved: (value) {
                              //   userName = value;
                              // },
                              // 当用户确定已经完成编辑时触发
                              onFieldSubmitted: (value) {},
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: LABLE_COLOR),
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                labelStyle: const TextStyle(color: DEF_FONT),
                                // labelText: '',
                                hintText: obj.inputB,
                                hintStyle: TextStyle(
                                  color: LABLE_COLOR,
                                  fontSize: 50.sp,
                                ),
                                // prefixIcon: Icon(Icons.person),
                              ),
                              style: TextStyle(
                                color: DEF_FONT,
                                fontSize: 50.sp,
                              ),
                              //是否是密码
                              // obscureText: true,
                              // //校验密码
                              // validator: (value) {
                              //   return value.length < 6 && value.length > 0 ? '密码长度不够 6 位' : null;
                              // },
                              // onSaved: (value) {
                              //   password = value;
                              // },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    idx > 0 ? btnPrv() : Container(),
                    btnNext(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
