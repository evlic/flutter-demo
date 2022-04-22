import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_address_book_local/demo-elm/css.dart';
import 'package:flutter_address_book_local/util/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'detail_page.dart';
import 'img.dart';

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

  @override
  String toString() {
    return 'User{id: $id, userName: $userName, email: $email, phoneNum: $phoneNum, avatarUrl: $avatarUrl}';
  }

  static User map2User(Map<String, Object?> map) {
    return User(
      map["id"]! as int,
      map["userName"]! as String,
      map["email"]! as String,
      map["phoneNum"]! as String,
      map["avatarUrl"]! as String,
    );
  }

  static String item2String(Item? item){
    if (item == null) { return ""; }
    return item.value!;
  }

  static User contact2User(Contact contact) {
    var userName = "";
    var email = "";
    var phoneNum = "";
    var avatarUrl = "avatarUrl";

    if (contact.displayName != null) {userName =  contact.displayName!;}
    if (contact.emails != null &&contact.emails!.isNotEmpty) {email =  item2String(contact.emails![0]);}
    if (contact.phones != null &&contact.phones!.isNotEmpty) {phoneNum =  item2String(contact.phones![0]);}

    return User(-1, userName, email, phoneNum, avatarUrl);
  }
}
