import 'package:flutter/material.dart';
import 'package:flutter_address_book/demo-elm/css.dart';
import 'package:flutter_address_book/util/toast.dart';

import 'detail_page.dart';

class User {
  int id;
  String userName;
  String email;
  String phoneNum;
  String avatarUrl;
  User(this.id, this.userName, this.email, this.phoneNum, this.avatarUrl);

  static List<User> testUsers = <User>[
    User(1, "xx0", "work0@xx.cm", "123432", "avatarUrl"),
    User(2, "xx1", "work1@xx.cm", "123433", "avatarUrl"),
    User(3, "xx2", "work2@xx.cm", "123434", "avatarUrl"),
    User(4, "xx3", "work3@xx.cm", "123435", "avatarUrl"),
    User(5, "xx4", "work4@xx.cm", "123436", "avatarUrl"),
  ];

  static User map2User(Map<String, Object?> map) {
    return User(
      map["id"]! as int,
      map["userName"]! as String,
      map["email"]! as String,
      map["phoneNum"]! as String,
      map["avatarUrl"]! as String,
    );
  }
}

class UserLine extends StatelessWidget {
  const UserLine({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return Container(
        // 样式调整...
        padding: ComEdge.defAllEdge10,
        margin: ComEdge.defAllEdge20,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserInfoPage(user: user),
                    ))
                .then((value) =>
                    value != null ? logMsg(msg: value) : print("null"));
          },
          child: Text("TODO"),
        ));
  }
}
