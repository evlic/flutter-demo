import 'dart:math';

import 'package:flutter/material.dart';
import '../demo-elm/css.dart';
import 'img.dart';
import 'css.dart';
import '/util/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dao.dart';
import 'item.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  String msg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("「${widget.user.userName}」"),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context, msg);
            },
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Images.buildAvatar(widget.user),
                  buildInfo(),
                ],
              ),
              // buildOptArea()
              // 操作区
            ],
          ),
        ));
  }

  Widget buildTextField(int idx, dynamic v) {
    textController[idx].text = v.toString();
    return  TextFormField(
      controller: textController[idx],

      decoration: InputDecoration(
        // border: OutlineInputBorder(
        //   // borderSide: BorderSide(color: lableColor),
        //   borderRadius: BorderRadius.circular(10.sp),
        // ),
        // labelText: '',
        hintText: infoList[idx],
        hintStyle: TextStyle(
          color: ComColors.sub,
          fontSize: 50.sp,
        ),
        prefixText: "${infoList[idx]}:",
        // prefixIcon: Icon(Icons.person),
      ),
      style: TextStyle(
        fontSize: 50.sp,
      ),
      onFieldSubmitted: (value) {},
    );
  }
  List<String> infoList = <String>["姓名", "邮箱", "电话"];
  List<TextEditingController> textController = [TextEditingController(), TextEditingController(), TextEditingController()];
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  Widget buildInfo() {
    User user = widget.user;
    return Expanded(
      flex: 3,
        child:Form(
          //设置globalKey，用于后面获取FormState
          key: loginKey,
          //开启自动校验
          // autovalidate: true,
          child: Column(
            children: <Widget>[
              buildTextField(0, user.userName),
              buildTextField(1, user.email),
              buildTextField(2, user.phoneNum),

            ],
          ),
        )
    );
  }

  Widget buildOptArea() {
    var list = [buildSaveBtn()];
    if (widget.user.id > 0 ){
      list.add(buildDelBtn());
    }
    return Row(
      children: list,
    );
  }

  save() {
    // var user = widget.user;
    // user.userName = textController[0].text;
    // user.email = textController[1].text;
    // user.phoneNum = textController[2].text;
    // if (user.id < 0) {
    //   DB.insertUser(user);
    //   msg = "保存新增数据";
    // } else {
    //   DB.saveUser(user);
    //   msg = "执行保存更新数据";
    // }
    // Navigator.pop(context, msg);
    logMsg(msg: "readOnly");
  }

  del() {
    DB.delUser(widget.user);
    msg = "已删除 ${widget.user}";
    print("del");
    Navigator.pop(context, msg);
  }

  Widget buildSaveBtn() {
    return buildBtn(onPressed: save, child: Text("保存"));
  }

  Widget buildDelBtn() {
    return buildBtn(onPressed: del, child: Text("删除-TODO"));
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
}
