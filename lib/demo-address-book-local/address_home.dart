import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'dao.dart';
import 'detail_page.dart';
import 'item.dart';
import '/util/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

import '../demo-elm/css.dart';
import '../util/save2file.dart';
import 'img.dart';

const iOSLocalizedLabels = false;


/* 
  通讯录的首页
  列表展示所有联系人粗略信息
  输入框检索
  新增
 */
class AbHomeLocal extends StatefulWidget {
  const AbHomeLocal(this.title, {Key? key}) : super(key: key);
  final String title;

  @override
  State<AbHomeLocal> createState() => _AbHomeLocalState();
}

class _AbHomeLocalState extends State<AbHomeLocal> {
  late List<User> dataList;
  late List<Contact> _contacts;

  @override
  void initState() {
    super.initState();
    dataList = [];
    _contacts = [];
    refreshContacts();
  }

  Future<void> refreshContacts() async {
    // Load without thumbnails initially.
    await _askPermissions("null");
    var contacts = (await ContactsService.getContacts(
        withThumbnails: false, iOSLocalizedLabels: iOSLocalizedLabels));
//      var contacts = (await ContactsService.getContactsForPhone("8554964652"))
//          ;
    setState(() {
      _contacts = contacts;
    });

    // Lazy load thumbnails after rendering initial contacts.
    for (final contact in contacts) {
      dataList.add(User.contact2User(contact));
    }
    logMsg(msg: "从系统通讯录中加载: ${dataList.length}");
    setState(() {

    });
  }

  Future<void> _askPermissions(String routeName) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
      SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
          // buildSearchInput(),
          Expanded(flex: 10, child: ListView(children: widgetList)),
        ],
      ),
      // 新增联系人按钮
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      //
      //   ///点击响应事
      //   onPressed: () {
      //     print(dataList);
      //     Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) =>
      //                   UserInfoPage(user: User(-1, "", "", "", "def")),
      //             ))
      //         .then((value) =>
      //             value != null ? logMsg(msg: value) : print("null"));
      //   },
      //
      //   ///长按提示
      //   tooltip: "点击了 tooltip s ",
      //
      //   ///设置悬浮按钮的背景
      //   backgroundColor: Colors.blue,
      //
      //   ///获取焦点时显示的颜色
      //   focusColor: Colors.green,
      //
      //   ///鼠标悬浮在按钮上时显示的颜色
      //   hoverColor: Colors.yellow,
      //
      //   ///水波纹颜色
      //   splashColor: Colors.deepPurple,
      //
      //   ///定义前景色 主要影响文字的颜色
      //   foregroundColor: Colors.black,
      //
      //   ///配制阴影高度 未点击时
      //   elevation: 5.0,
      //
      //   ///配制阴影高度 点击时
      //   highlightElevation: 20.0,
      // ),
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
