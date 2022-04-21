import 'package:flutter/material.dart';
import 'package:flutter_elm/util/toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'css.dart';

class ElmOrderApp extends StatefulWidget {
  const ElmOrderApp({Key? key}) : super(key: key);

  @override
  createState() => _ElmOrderMenuState();
}

// 简易的商品类
class Ware {
  static const String eCLoud =
      "https://pub.evlic.cloud/coding/flutter-demo/pic/";
  static const String eCLoudDefSuffix = ".jpg";

  Ware(this.image, this.wareTitle, this.originPrice, this.price, this.priceNum);

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
  final String originPrice;

  // 价格
  final String price;
  final int priceNum;

  static List<Ware> wartList = <Ware>[
    Ware(
      Ware.eCloudImage("baixiang-thh"),
      "白象 方便面 汤好喝招牌猪骨汤面 泡面 五连包",
      "¥24.80",
      "¥14.80",
      1480,
    ),
    Ware(
      Ware.eCloudImage("baixiang-thh"),
      "白象 方便面 汤好喝招牌猪骨汤面 泡面 五连包",
      "¥24.80",
      "¥15.80",
      1580,
    ),
    Ware(
      Ware.eCloudImage("baixiang-thh"),
      "白象 方便面 汤好喝招牌猪骨汤面 泡面 五连包",
      "¥24.80",
      "¥16.80",
      1680,
    ),
    Ware(
      Ware.eCloudImage("baixiang-thh"),
      "白象 方便面 汤好喝招牌猪骨汤面 泡面 五连包",
      "¥24.80",
      "¥17.80",
      1780,
    ),
    Ware(
      Ware.eCloudImage("baixiang-thh"),
      "白象 方便面 汤好喝招牌猪骨汤面 泡面 五连包",
      "¥24.80",
      "¥18.80",
      1880,
    ),
    Ware(
      Ware.eCloudImage("baixiang-thh"),
      "白象 方便面 汤好喝招牌猪骨汤面 泡面 五连包",
      "¥24.80",
      "¥19.80",
      1980,
    ),
    Ware(
      Ware.eCloudImage("baixiang-thh"),
      "白象 方便面 汤好喝招牌猪骨汤面 泡面 五连包",
      "¥24.80",
      "¥20.80",
      2080,
    ),
  ];
}

class _ElmOrderMenuState extends State<ElmOrderApp> {
  static final EdgeInsets _defEdge =
      EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10.sp, bottom: 10.sp);
  static final BorderRadius _defRadius = BorderRadius.circular(20.sp);
  static const circleBorder = CircleBorder();

  // 商品列表
  late Map<Ware, int> wareMap;

  get _wares => wareMap.keys;

  late double _totalD;
  late int _totalInt;

  late int _selectedCnt;

  @override
  void initState() {
    super.initState();
    _totalD = 0.0;
    _totalInt = 0;
    _selectedCnt = 0;
    wareMap = {for (var item in Ware.wartList) item: 0};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
      child: buildCart(),
    );
  }

  // 构建购物车组件
  Widget buildCart() {
    var resLit = buildWares();

    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: resLit,
          ),
        ),
        buildCheckOutCnt(),
      ],
    );
  }

  Container buildCheckOutCnt() {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(top: 5.sp, bottom: 25.sp),
      // 结算按钮和金额
      child: SizedBox(
        // height: 100.h,
        width: 1080.w,
        child: Container(
            child: Row(children: [
          //总计价格
          Expanded(
            flex: 2,
            child: Row(children: [
              Text("总计：", style: ComTextStyle.title),
              Text(_totalD.toString(), style: ComTextStyle.cost),
            ]),
          ),
          Container(
            height: 90.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              gradient: const LinearGradient(colors: [
                ComColors.elmBlue,
                Color(0xffde53fc),
                Color(0xff846dfc),
                // Color(0xff30c1fd),
              ]),
            ),
            child: ElevatedButton(
              onPressed: () {
                var str = "您已选购: ";
                wareMap.forEach((key, value) {
                  if (value > 0 ) {
                    str += "${key.wareTitle} * $value\t";
                  }
                });
                logMsg(msg: str, time: 1200);
              },
              child: Text(
                "去结算($_selectedCnt)",
                style: TextStyle(
                  color: ComColors.card,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ButtonStyle(
                //去除阴影
                elevation: MaterialStateProperty.all(0),
                //将按钮背景设置为透明
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
            ),
          )
        ])),
      ),
    );
  }

  List<Widget> buildWares() {
    var resLit = <Widget>[];

    for (var ware in _wares) {
      resLit.add(buildWareCard(ware));
    }

    return resLit;
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

  _addWare(Ware ware) {
    _totalInt += ware.priceNum;
    _totalD = _totalInt / 100;
    _selectedCnt++;
    wareMap[ware] = wareMap[ware]! + 1;
    setState(() {});
  }

  // 渲染单个商品
  Widget _renderWareItem(Ware ware) {
    // 单个 商品项展示
    return Row(
      // 设置顶部对齐
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // image
        Expanded(
          // 图片
          child: ClipRRect(
            child: ware.image,
            borderRadius: _defRadius,
          ),
          flex: 1,
        ),
        // 商品名 原价、价格、加号 btn
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
              Row(children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: _defEdge,
                    child: Row(
                      children: [
                        // 现价
                        Text(
                          ware.price,
                          textAlign: TextAlign.center,
                          style: ComTextStyle.price,
                        ),
                        // 原价
                        Container(
                          padding: _defEdge,
                          child: Text(
                            ware.originPrice,
                            maxLines: 1,
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: ComColors.sub,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // 加购按钮
                Expanded(
                  flex: 1,
                  child: Container(
                      padding: _defEdge,
                      margin: _defEdge,
                      child: ElevatedButton(
                        onPressed: () {
                          _addWare(ware);
                        },
                        child: Text(
                          "+",
                          style:
                              TextStyle(color: ComColors.card, fontSize: 60.sp),
                        ),
                      )),
                ),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
