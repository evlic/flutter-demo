import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_address_book/demo-elm/comment.dart';
import 'package:flutter_address_book/demo-elm/order.dart';
import 'package:flutter_address_book/demo-elm/store_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'css.dart';

const String title = "Fake ELM";

class ElmApp extends StatefulWidget {
  const ElmApp({Key? key}) : super(key: key);

  @override
  State<ElmApp> createState() => _ElmAppState();
}

class _ElmAppState extends State<ElmApp> {
  @override
  Widget build(BuildContext context) {
    var title = "Fake 饿了么";
    var info = "点进进入「乡村基」";
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ElmMainTabsApp(),
              )).then((value) => null);
        },
        child: Center(
            child: Text(
          title,
          style: TextStyle(fontSize: 120.sp),
        )),
      ),
    );
  }
}

class ElmMainTabsApp extends StatefulWidget {
  const ElmMainTabsApp({Key? key}) : super(key: key);

  @override
  State<ElmMainTabsApp> createState() => _ElmMainTabsAppState();
}

class _ElmMainTabsAppState extends State<ElmMainTabsApp>
    with SingleTickerProviderStateMixin {
  late List<String> tabs;
  late String title;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    tabs = ["点餐", "评价", "商家"];
    title = "你饿了么？";
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    // 释放资源
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [ElmOrderApp(), ElmCommentApp(), ElmStoreInfoApp()],
      ),
    );
  }
}