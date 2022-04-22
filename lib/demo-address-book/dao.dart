// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter_address_book/util/toast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'item.dart';

class DB {
  static String dbsPath = "";

  static init({String dbName = "demo.db"}) async {
    dbsPath = await getDatabasesPath();
  }

  static Future<Database> open({String dbName = "demo.db"}) async {
    if (dbsPath == "") {
      await init();
    }

    return await openDatabase(join(dbsPath, dbName), version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, userName TEXT, email TEXT, phoneNum TEXT, avatarUrl TEXT)');
    });
  }

  // 模糊查询
  static Future<List<User>> queryUsers(
      {String dbName = "demo.db", String fuzzy = ""}) async {
    late List<Map<String, Object?>> res;
    late String SQL;
    var db = await open();

    if (fuzzy != "") {
      SQL =
          // 'SELECT * FROM Test WHERE `userName` like "$fuzzy%" or email like "$fuzzy%" or phoneNum like "$fuzzy%"';
          'SELECT * FROM Test WHERE userName LIKE "$fuzzy%"';
    } else {
      SQL = 'SELECT * FROM Test';
    }
    logMsg(msg: "doSQL -> $SQL");
    res = await db.rawQuery('SELECT * FROM Test');

    print("queryRes >> $res");

    var product = <User>[];
    res.forEach((element) {
      product.add(User.map2User(element));
    });


    return product;
  }

  // 保存 update
  static saveUser(User user) async {
    var db = await open();
    await db.transaction((txn) async {
      String SQL =
          'UPDATE Test SET userName = ?, email = ?, phoneNum = ?, avatarUrl = ? WHERE id = ? | ${[
        user.userName,
        user.email,
        user.phoneNum,
        user.avatarUrl,
        user.id
      ]}';
      logMsg(msg: "doSQL -> $SQL");

      int count = await db.rawUpdate(
          'UPDATE Test SET userName = ?, email = ?, phoneNum = ?, avatarUrl = ? WHERE id = ?',
          [user.userName, user.email, user.phoneNum, user.avatarUrl, user.id]);
      logMsg(msg: 'updated -> $count');
    });

  }

  // 插入 user 数据
  static insertUser(User user, {String dbName = "demo.db"}) async {
    var db = await open();
    await db.transaction((txn) async {
      String SQL =
          'INSERT INTO Test(userName, email, phoneNum, avatarUrl) VALUES ("${user.userName}", "${user.email}","${user.phoneNum}", "${user.avatarUrl}")';
      // logMsg(msg: "doSQL -> $SQL");
      int newId = await txn.rawInsert(SQL);
      // logMsg(msg: 'inserted: $newId');
      user.id = newId;
    });

  }

  // static insertUsers(List<User> users, {String dbName = "demo.db"}) async {
  //   await db.transaction((txn) async {
  //     String SQL =
  //         'INSERT INTO Test(id, userName, email, phoneNum, avatarUrl) VALUES (${user.id}, "${user.userName}", "${user.phoneNum}", "${user.avatarUrl}")';
  //     // logMsg(msg: "doSQL -> $SQL");
  //     int newId = await txn.rawInsert(SQL);
  //     // logMsg(msg: 'inserted: $newId');
  //     user.id = newId;
  //   });
  // }
  // TODO 删除
  static delUser(User user, {String dbName = "demo.db"}) async {
    // Delete a record
    // count = await db
    //     .rawDelete('DELETE FROM Test WHERE name = ?', ['another name']);


    var db = await open();
    await db.transaction((txn) async {
      String SQL =
          'DELETE FROM Test WHERE id = ?';
      // logMsg(msg: "doSQL -> $SQL");
      int cnt = await txn.rawDelete(SQL, [user.id]);
    });
  }
}
