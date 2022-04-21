import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_address_book/demo-address-book/img.dart';
import 'package:flutter_address_book/util/toast.dart';

import 'item.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  late String msg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("「${widget.user.userName}」"),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  buildAvatar(),
                  buildInfo(),
                ],
              ),
              buildOptArea()
              // 操作区
            ],
          ),
        ));
  }

  Widget buildAvatar() {
    late Image res;
    var aUrl = widget.user.avatarUrl;
    var r = 0;
    for (var i = 0; i < Images.imageUrl.length; i++) {
      if (Images.imageUrl[i] == aUrl) {
        r = i;
        break;
      }
    }

    if (r == 0) {
      Random().nextInt(Images.images.length);
    }

    widget.user.avatarUrl = Images.imageUrl[r];
    res = Images.images[r];

    // todo 包装
    return res;
  }

  Widget buildInfo() {
    return Text("doing");
  }

  Widget buildOptArea() {
    return Row(
      children: [buildSaveBtn(), buildDelBtn()],
    );
  }

  save() {
    logMsg(msg: "will do save");
  }

  del() {
    logMsg(msg: "will do del");
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
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
