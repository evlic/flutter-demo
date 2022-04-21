import 'package:flutter/material.dart';
import 'package:flutter_address_book/demo-address-book/dao.dart';
import 'package:flutter_address_book/demo-address-book/detail_page.dart';
import 'package:flutter_address_book/demo-address-book/item.dart';
import 'package:flutter_address_book/util/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/save2file.dart';

/* 
  通讯录的首页
  列表展示所有联系人粗略信息
  输入框检索
  新增
 */
class AbHome extends StatefulWidget {
  const AbHome(this.title, {Key? key}) : super(key: key);
  final String title;
  @override
  State<AbHome> createState() => _AbHomeState();
}

class _AbHomeState extends State<AbHome> {
  late List<User> dataList;

  @override
  void initState() {
    super.initState();
    dataList = [];
    Future.delayed(
        Duration.zero,
        () => setState(() {
              initByMySelf();
            }));
  }

  initByMySelf() async {
    String state = await read();
    print("state >> $state");
    if (state != ReadState.error && state == "1") {
      print("从数据库读取 user");
      await DB.init();
      dataList = await DB.queryUsers();
      setState(() {});
      if (dataList.isEmpty) {
        await dataDef();
      }
    } else {
      await dataDef();
    }
  }

  dataDef() async {
    dataList = User.testUsers;
    logMsg(msg: "读取默认，并写入数据库");
    for (var user in dataList) {
      DB.insertUser(user);
      setState(() {});
    }
    var tmp = await DB.queryUsers();
    if (tmp.isNotEmpty) {
      print("默认数据写入数据库成功");
      await write(json: "1");
    } else {
      print("默认数据写入数据库失败");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<UserLine> widgetList = <UserLine>[];
    for (var user in dataList) {
      widgetList.add(UserLine(user: user));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(children: widgetList),
      // 新增联系人按钮
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),

        ///点击响应事
        onPressed: () {
          print(dataList);
          Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UserInfoPage(user: User(-1, "", "", "", "def")),
                  ))
              .then((value) =>
                  value != null ? logMsg(msg: value) : print("null"));
        },

        ///长按提示
        tooltip: "点击了 tooltip s ",

        ///设置悬浮按钮的背景
        backgroundColor: Colors.red,

        ///获取焦点时显示的颜色
        focusColor: Colors.green,

        ///鼠标悬浮在按钮上时显示的颜色
        hoverColor: Colors.yellow,

        ///水波纹颜色
        splashColor: Colors.deepPurple,

        ///定义前景色 主要影响文字的颜色
        foregroundColor: Colors.black,

        ///配制阴影高度 未点击时
        elevation: 0.0,

        ///配制阴影高度 点击时
        highlightElevation: 20.0,
      ),
    );
  }
}
