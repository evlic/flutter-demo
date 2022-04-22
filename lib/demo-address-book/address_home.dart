import 'package:flutter/material.dart';
import 'package:flutter_address_book/demo-address-book/dao.dart';
import 'package:flutter_address_book/demo-address-book/detail_page.dart';
import 'package:flutter_address_book/demo-address-book/item.dart';
import 'package:flutter_address_book/util/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../demo-elm/css.dart';
import '../util/save2file.dart';
import 'img.dart';

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
  // 由于使用 SQLlite 的模糊查询遇到未知问题, 没有排除数据项, 所以选择手动实现
  doFuzzy() {
    print("手动 do fuzzy");
    var delList = <User>[];
    for (var value in dataList) {
      if (!value.userName.startsWith(fuzzyIn.text)) {
        delList.add(value);
      }
    }
    for (var v in delList) {
      dataList.remove(v);
    }
  }

  initByMySelf() async {
    String state = await read();
    // print("state >> $state");
    if (state != ReadState.error && state == "1") {
      // print("从数据库读取 user");
      await DB.init();
      dataList = await DB.queryUsers(fuzzy: fuzzyIn.text);
      if (fuzzyIn.text != "") {
        doFuzzy();
      } else {
        print("fuzzy >>　raw");
      }

      logMsg(msg: fuzzyIn.text);
      setState(() {});
      if (dataList.isEmpty && fuzzyIn.text == "") {
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
    }
    var tmp = await DB.queryUsers();
    setState(() {});
    if (tmp.isNotEmpty) {
      // print("默认数据写入数据库成功");
      await write(json: "1");
    } else {
      // print("默认数据写入数据库失败");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    for (var user in dataList) {
      widgetList.add(buildUserLine(user));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          buildSearchInput(),
          Expanded(flex: 10, child: ListView(children: widgetList)),
        ],
      ),
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
        backgroundColor: Colors.blue,

        ///获取焦点时显示的颜色
        focusColor: Colors.green,

        ///鼠标悬浮在按钮上时显示的颜色
        hoverColor: Colors.yellow,

        ///水波纹颜色
        splashColor: Colors.deepPurple,

        ///定义前景色 主要影响文字的颜色
        foregroundColor: Colors.black,

        ///配制阴影高度 未点击时
        elevation: 5.0,

        ///配制阴影高度 点击时
        highlightElevation: 20.0,
      ),
    );
  }

  Widget buildBtn({
    required VoidCallback? onPressed,
    required Widget? child,
  }) {
    return Container(
      margin: ComEdge.defAllEdge10,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }

  ref() {
    fuzzyIn.text= "";
    Future.delayed(
        Duration.zero,
            () => setState(() {
          initByMySelf();
        }));
  }

  Widget buildRefBtn() {
    return Expanded(
        child: buildBtn(onPressed: ref, child: Icon(Icons.refresh)));
  }

  search() {
    Future.delayed(
        Duration.zero,
            () => setState(() {
          initByMySelf();

        }));
  }

  Widget buildDoSearchBtn() {
    return Expanded(
        child: buildBtn(onPressed: search, child: Icon(Icons.search)));
  }

  var fuzzyIn = TextEditingController();

  Widget buildFuzzyInput() {
    return Expanded(
      flex: 4,
      child: TextFormField(
        controller: fuzzyIn,
        decoration: InputDecoration(
          // border: OutlineInputBorder(
          //   // borderSide: BorderSide(color: lableColor),
          //   borderRadius: BorderRadius.circular(10.sp),
          // ),
          // labelText: '',
          // hintText: infoList[idx],
          hintStyle: TextStyle(
            color: ComColors.sub,
            fontSize: 50.sp,
          ),
          // prefixText: "${infoList[idx]}:",
          // prefixIcon: Icon(Icons.person),
        ),
        style: TextStyle(
          fontSize: 50.sp,
        ),
        onFieldSubmitted: (value) {},
      ),
    );
  }

  Widget buildSearchInput() => Container(
        margin: ComEdge.defAllEdge20,
        padding: ComEdge.defAllEdge10,
        height: 120.sp,
        child: Row(
          children: [buildFuzzyInput(), buildRefBtn(), buildDoSearchBtn()],
        ),
      );

  Container buildUserLine(User user) {
    return Container(
        // 样式调整...
        padding: ComEdge.defAllEdge10,
        margin: ComEdge.defAllEdge20,
        child: GestureDetector(
          onTap: () async {
            var msg = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserInfoPage(user: user),
                ));
            print(">> get msg >>");
            if (msg != null && msg != "") {
              logMsg(msg: msg);
              // print("msg >> $msg");
              if (msg.startsWith("已删除")) {
                user.id = -1;
                dataList.remove(user);
              }
              setState(() {});
            } else {
              print("null");
            }
          },
          //     value != null ? () {
          //   logMsg(msg: value);
          //   print("msg >> $value");
          //   if (value.startsWith("已删除")) {
          //     user.id = -1;
          //   }
          //   changed(user);
          // } : print("null"));

          child: Container(
            padding: ComEdge.defAllEdge10,
            margin: ComEdge.defAllEdge20,
            height: 240.sp,
            // width: 1080.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Images.buildAvatar(user),
                Expanded(flex: 6, child: Text("「${user.userName}」")),
              ],
            ),
          ),
        ));
  }
}
