import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShoppingCartApp extends StatefulWidget {
  const ShoppingCartApp({Key? key}) : super(key: key);

  @override
  createState() => CartState();
}

class ComColors {
  // 背景颜色
  static const backGroundColor = Colors.black;
  // card 背景颜色
  static const Color card = Color.fromARGB(0xff, 29, 29, 29);
  // 默认字体颜色
  static const Color def = Color.fromARGB(0xff, 236, 236, 236);
  // sub 子字体颜色
  static const Color sub = Color.fromARGB(0xff, 131, 131, 131);
  // JD 红色
  static const Color jdR = Color.fromARGB(0xff, 254, 56, 37);
}

class ComTextStyle {
  // 店铺信息字体格式
  static TextStyle trade = TextStyle(
    color: ComColors.def,
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
  );

  // 商品标题 title
  static TextStyle title = TextStyle(
    color: ComColors.def,
    fontSize: 36.sp,
    fontWeight: FontWeight.w600,
  );

  // 商品选项
  static TextStyle subTitle = TextStyle(
      color: ComColors.sub, fontSize: 30.sp, fontWeight: FontWeight.normal);

  // 商品价格
  static TextStyle price = TextStyle(
      color: ComColors.jdR, fontSize: 36.sp, fontWeight: FontWeight.w600);

  // 商品数量
  static TextStyle num = TextStyle(
      color: ComColors.sub, fontSize: 28.sp, fontWeight: FontWeight.w600);

  // 商品总价
  static TextStyle cost = TextStyle(
      color: ComColors.jdR, fontSize: 36.sp, fontWeight: FontWeight.w600);

// static const TextStyle smallSize = TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal);
}

// 简易的商品类
class Ware {
  static const String eCLoud =
      "https://pub.evlic.cloud/coding/flutter-demo/pic/";
  static const String eCLoudDefSuffix = ".jpg";

  Ware(this.image, this.wareTitle, this.subTitle, this.tradeName, this.price,
      this.priceNum);

  static Image eCloudImage(String imageName) {
    return Image.network(
      eCLoud + imageName + eCLoudDefSuffix,
      filterQuality: FilterQuality.high,
      fit: BoxFit.cover,
    );
  }

  // 商品图片
  late Image image;
  // 商品名称
  final String wareTitle;
  // 商品子选项
  final String subTitle;
  // 商家名称
  final String tradeName;
  // 价格
  final String price;
  final int priceNum;
}

class CartState extends State<ShoppingCartApp> {
  late List<Ware> wartList = <Ware>[
    Ware(
      Ware.eCloudImage("baixiang-thh"),
      "白象 方便面 汤好喝招牌猪骨汤面 泡面 五连包",
      "汤好喝招牌猪骨汤面-五连包",
      "白象京东自营旗舰店",
      "¥14.80",
      1480,
    ),
    Ware(
      Ware.eCloudImage("iphone-13"),
      "Apple iPhone 13 (A2634) 256GB 星光色 支持移动联通电信5G 双卡双待手机",
      "星光色，256GB， 官方标配，选服务",
      "Apple产品京东自营旗舰店",
      "¥6799.00",
      679900,
    ),
    Ware(
      Ware.eCloudImage("logitech-g903"),
      "罗技（G）G903 LIGHTSPEED 无线电竞游戏鼠标 全新hero芯片 逻辑赛博朋克宏吃鸡鼠标 G903HERO无线游戏鼠标",
      "G903HERO无线游戏鼠标，选服务",
      "罗技G京东自营旗舰店",
      "¥599.00",
      59900,
    ),
    Ware(
      Ware.eCloudImage("baixiang-thh"),
      "白象 方便面 汤好喝招牌猪骨汤面 泡面 五连包",
      "汤好喝招牌猪骨汤面-五连包",
      "白象京东自营旗舰店",
      "¥14.80",
      1480,
    ),
    Ware(
      Ware.eCloudImage("iphone-13"),
      "Apple iPhone 13 (A2634) 256GB 星光色 支持移动联通电信5G 双卡双待手机",
      "星光色，256GB， 官方标配，选服务",
      "Apple产品京东自营旗舰店",
      "¥6799.00",
      679900,
    ),
    Ware(
      Ware.eCloudImage("logitech-g903"),
      "罗技（G）G903 LIGHTSPEED 无线电竞游戏鼠标 全新hero芯片 逻辑赛博朋克宏吃鸡鼠标 G903HERO无线游戏鼠标",
      "G903HERO无线游戏鼠标，选服务",
      "罗技G京东自营旗舰店",
      "¥599.00",
      59900,
    ),
  ];

  // 每个商品的开关
  static final Map<Ware, bool> _wareSwitchMap = {};
  // 店铺开关
  static final Map<String, bool> _tradeSwitchMap = {};
  // 每个商品与店铺的对应关系 todo 关联
  static final Map<String, Set<Ware>> _tradeMap = {};

  // 总金额
  static double _total = 0.0;
  static int _total_ = 0;
  static const int _offset = 100;

  static int _selectedCnt = 0;
  static bool _selectAll = false;
  static final EdgeInsets _defEdge =
  EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10.sp, bottom: 10.sp);
  static final BorderRadius _defRadius = BorderRadius.circular(20.sp);
  static const circleBorder = CircleBorder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "购物车",
          style: TextStyle(fontSize: 60.sp),
        ),
        backgroundColor: ComColors.backGroundColor,
      ),
      backgroundColor: ComColors.backGroundColor,
      body: Container(
        padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
        child: buildCart(),
      ),
    );
  }

  // 构建购物车组件
  Widget buildCart() {
    var resLit = <Widget>[];
    for (var ware in wartList) {
      // 关联 map
      var tradeSet = _tradeMap.putIfAbsent(ware.tradeName, () => <Ware>{ware});
      tradeSet.add(ware);
    }
    _tradeMap.forEach((_, set) {
      resLit.add(buildTradeWars(set));
    });

    return Column(
      children: <Widget>[
        // 标题
        Container(
            padding: EdgeInsets.all(10.sp),
            child: const Text("evlic@FACK JD 购物车")),
        Expanded(
          child: ListView(
            children: resLit,
          ),
        ),
        // 表单数据
        Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.only(top: 5.sp, bottom: 25.sp),
          // 结算按钮和金额
          child: SizedBox(
            // height: 100.h,
            width: 1080.w,
            child: Container(
                child: Row(children: [
                  //    全选
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: _checkBoxAll(),
                        ),
                        Text("全选", style: ComTextStyle.title),
                      ],
                    ),
                  ),
                  //总计价格
                  Expanded(
                    flex: 2,
                    child: Row(children: [
                      Text("总计：", style: ComTextStyle.title),
                      Text(_total.toString(), style: ComTextStyle.cost),
                    ]),
                  ),
                  Container(
                    height: 90.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      gradient: const LinearGradient(colors: [
                        ComColors.jdR,
                        Color(0xffde53fc),
                        Color(0xff846dfc),
                        // Color(0xff30c1fd),
                      ]),
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "去结算($_selectedCnt)",
                        style: ComTextStyle.title,
                      ),
                      style: ButtonStyle(
                        //去除阴影
                        elevation: MaterialStateProperty.all(0),
                        //将按钮背景设置为透明
                        backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                      ),
                    ),
                  )
                ])),
          ),
        ),
      ],
    );
  }

  // 构建店铺下的所有商品
  Widget buildTradeWars(Set<Ware> set) {
    var resLit = <Widget>[_renderTradeInfo(set)];

    for (var ware in set) {
      resLit.add(buildWareCard(ware));
    }

    return Container(
      margin: EdgeInsets.all(5.sp),
      padding: EdgeInsets.all(25.sp),
      child: Column(children: resLit),
      decoration: BoxDecoration(
        borderRadius: _defRadius,
        color: ComColors.card,
      ),
    );
  }

  // 构建购物车单个卡片
  Widget buildWareCard(Ware ware) {
    return Container(
      // margin: EdgeInsets.all(5.sp),
      padding: EdgeInsets.all(25.sp),

      // 店铺商品
      child: _renderWareItem(ware),
    );
  }

  // 渲染店铺信息
  Widget _renderTradeInfo(Set<Ware> set) {
    var tradeName = set.first.tradeName;
    _tradeSwitchMap.putIfAbsent(tradeName, () => false);

    return Row(children: [
      Container(
        alignment: Alignment.topLeft,
        child: _checkBoxTrade(tradeName),
      ),
      Container(
        padding: EdgeInsets.only(top: 10.sp, bottom: 36.sp),
        // padding: edgeDef,
        alignment: Alignment.centerLeft,
        child: Text(
          tradeName,
          style: ComTextStyle.trade,
          textAlign: TextAlign.left,
        ),
      ),
    ]);
  }

  // 渲染单个商品
  Widget _renderWareItem(Ware ware) {
    _wareSwitchMap.putIfAbsent(ware, () => false);

    // 单个 商品项展示
    return Row(
      // 设置顶部对齐
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // checkBox
        Container(
          alignment: Alignment.topLeft,
          child: _checkBoxWare(ware),
        ),
        // image
        Expanded(
          child: ClipRRect(
            child: ware.image,
            borderRadius: _defRadius,
          ),
          flex: 1,
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: <Widget>[
              Container(
                padding: _defEdge,
                margin: _defEdge,
                child: Text(
                  ware.wareTitle,
                  maxLines: 2,
                  style: ComTextStyle.title,
                ),
              ),
              Container(
                padding: _defEdge,
                margin: _defEdge,
                child: Text(
                  ware.subTitle,
                  maxLines: 1,
                  style: ComTextStyle.subTitle,
                ),
              ),
              Row(children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: _defEdge,
                    child: Text(
                      ware.price,
                      textAlign: TextAlign.center,
                      style: ComTextStyle.price,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: _defEdge,
                    margin: _defEdge,
                    child: Text(
                      "TODO: num 计数器占位",
                      style: ComTextStyle.num,
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ],
    );
  }

  Checkbox _defCheckBox({ValueChanged<bool?>? onChanged, bool? value}) {
    return Checkbox(
      tristate: false,
      // 圆形
      shape: const CircleBorder(),
      activeColor: ComColors.jdR,
      checkColor: ComColors.def,
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _checkBoxWare(Ware ware) {
    return _defCheckBox(
      value: _wareSwitchMap[ware],
      onChanged: (bool? value) {
        _doSwitchCheckBox(ware, value!);
        _checkTrade(ware);
        _checkAll();
        setState(() {});
      },
    );
  }

  Widget _checkBoxTrade(String tradeName) {
    return _defCheckBox(
      value: _tradeSwitchMap[tradeName],
      onChanged: (bool? value) {
        _selectTrad(tradeName, value!);
      },
    );
  }

  Widget _checkBoxAll() {
    return _defCheckBox(
      value: _selectAll,
      onChanged: (bool? value) {
        _selectAll = value!;
        _selectAllCheckBox(value);
        setState(() {});
      },
    );
  }

  // 执行商品前 checkbox 切换，并更新 总价格
  void _doSwitchCheckBox(Ware ware, bool val) {
    var nowState = _wareSwitchMap[ware];
    if (nowState == !val) {
      switch (nowState) {
      // 减少选中
        case true:
          {
            _total_ -= ware.priceNum;
            --_selectedCnt;
          }
          break;
      // 增加
        case false:
          {
            _total_ += ware.priceNum;
            ++_selectedCnt;
          }
          break;
      }
      _total = _total_ / _offset;
      _wareSwitchMap[ware] = val;
    } else {
      // log("不更新 >>  ${_wareSwitchMap.toString()}");
    }
  }

  // 店铺选中
  void _selectTrad(String tradName, bool val) {
    var set = _tradeMap[tradName];

    if (set != null) {
      for (var ware in set) {
        _doSwitchCheckBox(ware, val);
      }
    } else {
      log("「$tradName」为空", time: DateTime.now());
    }
    _tradeSwitchMap[tradName] = val;
    _checkAll();
    setState(() {});
  }

  // 全选
  void _selectAllCheckBox(bool val) {
    _tradeSwitchMap.forEach((key, _) {
      _tradeSwitchMap[key] = val;
    });
    _wareSwitchMap.forEach((key, _) {
      _doSwitchCheckBox(key, val);
    });

    setState(() {});
  }

  // 检查店铺全选, 并检查全选状态
  void _checkTrade(Ware ware) {
    var key = ware.tradeName;
    bool? state;
    for (var bro in _tradeMap[key]!) {
      state = _wareSwitchMap[bro];
      // 取消店铺选中
      if (state != null && !state) {
        _tradeSwitchMap[key] = false;
        return;
      }
    }
    _tradeSwitchMap[key] = true;
    _checkAll();
  }

  // 检查全选状态
  void _checkAll() {
    bool? state;
    for (var key in _tradeSwitchMap.keys) {
      state = _tradeSwitchMap[key];
      // 有非全选状态直接推出
      if (state != null && !state) {
        _selectAll = false;
        return;
      }
    }
    log(_tradeSwitchMap.toString());
    _selectAll = true;
  }
}
