import 'dart:convert';

import 'package:edu_flutter_login_save/demo-login-form-save/save2file.dart';
import 'package:edu_flutter_login_save/util/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginFormAndSaveApp extends StatefulWidget {
  const LoginFormAndSaveApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class POJO {
  const POJO(this.label, this.inputA, this.inputB);

  final String label;
  final String inputA;
  final String inputB;
}

class UserInfo {
  final String name1, name2, userName, pwd;

  UserInfo(this.name1, this.name2, this.userName, this.pwd);

  UserInfo.fromJson(Map<String, dynamic> json)
      : name1 = json['name1'],
        name2 = json['name2'],
        userName = json['userName'],
        pwd = json['pwd'];

  Map<String, dynamic> toJson() => {
        'name1': name1,
        'name2': name2,
        'userName': userName,
        'pwd': pwd,
      };

  // 读入时调用
  List<List<TextEditingController>> usr2List() {
    return [
      [TextEditingController(text: name1), TextEditingController(text: name2)],
      [TextEditingController(text: userName), TextEditingController(text: pwd)],
    ];
  }

  // 保存时调用
  static UserInfo list2Usr(List<List<TextEditingController>> list) {
    return UserInfo(
        list[0][0].text, list[0][1].text, list[1][0].text, list[1][1].text);
  }

  @override
  String toString() {
    return 'User{$name1.$name2, userName: $userName, pwd: $pwd}';
  }
}

class _LoginState extends State<LoginFormAndSaveApp> {
  static const PAGE_BACKGROUND_COLOR = Colors.black;
  static const LINK_COLOR = Color(0xff4a80d8);
  static const lableColor = Colors.white60;
  static const DEF_FONT = Colors.white;

  static int idx = 0;
  static bool inited = false;

  static List<POJO> pojoList = [
    const POJO("请输入您的姓名", "姓氏", "名称"),
    const POJO("请自定义您的账户信息", "用户名", "密码"),
  ];

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  POJO obj = pojoList[idx];

  late List<List<TextEditingController>> textController;

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
              // 下一页点击事件
              onPressed: tapNext,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(LINK_COLOR),
              ),
              child: Text(
                idx < pojoList.length - 1 ? "下一步" : "提交",
                style: TextStyle(
                  color: PAGE_BACKGROUND_COLOR,
                  fontSize: 36.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void tapNext() {
    if (idx < pojoList.length) {
      // defToast(msg: "$idx");
      if (idx == pojoList.length - 1) {
        // 保存
        // 执行 list 转 usr 对象
        // 然后将 usr 对象转为 json 字符串写入文件保存

        var usr = UserInfo.list2Usr(textController);
        var jsonStr = jsonEncode(usr.toJson());
        logMsg(msg: "执行保存 >> $jsonStr", time: 1000);
        write(jsonStr);
      } else {
        idx++;
      }
      setState(() {
        obj = pojoList[idx];
      });
    } else {
      logMsg(msg: "出界的 idx $idx");
    }
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
                  obj = pojoList[idx] as POJO;
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
                fontSize: 36.sp,
              ),
            ),
          ),
        ),
      ),
    ));
  }

  render(String jsonStr) {
    if (jsonStr != ReadState.error) {
      // json 反序列化
      Map<String, dynamic> userMap = jsonDecode(jsonStr);
      var user = UserInfo.fromJson(userMap);
      textController = user.usr2List();
      setState(() {});
      logMsg(msg: '成功从文件系统中加载数据');
    } else {
      logMsg(msg: '新建表单以供用户写入账户信息');
      textController = [
        [TextEditingController(), TextEditingController()],
        [TextEditingController(), TextEditingController()]
      ];
    }
  }

  init() {
    if (!inited) {
      inited = !inited;
      // 读取历史数据
      Future.wait([read()]).then((value) => {
            render(value[0]),
            logMsg(msg: "成功加载 >> $value"),
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    init();
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
                        style: TextStyle(fontSize: 48.sp, color: lableColor),
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
                              controller: textController[idx][0],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: lableColor),
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                // labelText: '',
                                hintText: obj.inputA,
                                hintStyle: TextStyle(
                                  color: lableColor,
                                  fontSize: 50.sp,
                                ),
                                // prefixIcon: Icon(Icons.person),
                              ),
                              style: TextStyle(
                                color: DEF_FONT,
                                fontSize: 50.sp,
                              ),
                              onFieldSubmitted: (value) {},
                            ),
                            TextFormField(
                              controller: textController[idx][1],
                              obscureText: idx == 1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: lableColor),
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                labelStyle: const TextStyle(color: DEF_FONT),
                                // labelText: '',
                                hintText: obj.inputB,
                                hintStyle: TextStyle(
                                  color: lableColor,
                                  fontSize: 50.sp,
                                ),
                                // prefixIcon: Icon(Icons.person),
                              ),
                              style: TextStyle(
                                color: DEF_FONT,
                                fontSize: 50.sp,
                              ),
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
