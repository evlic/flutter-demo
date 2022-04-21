import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_address_book/demo-elm/css.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElmStoreInfoApp extends StatelessWidget {
  const ElmStoreInfoApp({Key? key}) : super(key: key);
  static final Store _stroe = Store(
    "乡村基(瑞福路店)",
    "重庆市渝北区龙兴镇和合家园C组团瑞福路24号楼45号45-1",
    [
      Store.image("head1"),
      Store.image("head2"),
    ],
    "09:30-22:00",
    "盖浇饭/其他快餐",
  );
  static final TextStyle infoTextStyle =
      TextStyle(fontSize: 60.sp, color: ComColors.sub);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: ComEdge.defAllEdge10,
          margin: ComEdge.defAllEdge20,
          decoration: ComBoxCard.defBox,
          height: 600.sp,
          child: StoreCard(_stroe),
        ),
        Container(
          padding: ComEdge.defAllEdge10,
          margin: ComEdge.defAllEdge20,
          decoration: ComBoxCard.defBox,
          child: Center(
              child: Text(
            "举报商家",
            style: infoTextStyle,
          )),
        ),
      ],
    );
  }
}

class StoreCard extends StatelessWidget {
  static final TextStyle title = TextStyle(
    color: ComColors.def,
    fontSize: 48.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle subTitle = TextStyle(
    color: ComColors.def,
    fontSize: 36.sp,
    fontWeight: FontWeight.w300,
  );

  final Store _store;

  const StoreCard(this._store, {Key? key}) : super(key: key);

  List<Widget> buildImageWrap(List list) {
    var res = <Widget>[];
    for (var value in list) {
      res.add(Container(
        margin: ComEdge.defAllEdge20,
        child: ClipRRect(
          borderRadius: ComBorder.defRadius,
          child: value,
        ),
      ));
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_store.name, style: title, textAlign: TextAlign.left),
        Text("地址: ${_store.location}",
            style: subTitle, textAlign: TextAlign.left),
        // Row(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: buildImageWrap(_store.pictures),
        ),
        Text("商家信息", style: title),
        Text("商品品类: ${_store.businessScope}",
            style: subTitle, textAlign: TextAlign.left),
        Text("营业时间: ${_store.businessHours}",
            style: subTitle, textAlign: TextAlign.left),
      ],
    );
  }
}

class Store {
  final String name;
  final String location;
  final List<Image> pictures;
  final String businessHours;
  final String businessScope;

  Store(this.name, this.location, this.pictures, this.businessHours,
      this.businessScope);

  static Image image(String name) {
    String eCloudUrl =
        "https://pub.evlic.cloud/coding/flutter-demo/elm/$name.jpg";
    return Image.network(
      eCloudUrl,
      filterQuality: FilterQuality.high,
      fit: BoxFit.cover,
      width: 200.sp,
      height: 200.sp,
    );
  }
}
