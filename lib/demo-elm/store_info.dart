import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreView extends StatelessWidget {
  const StoreView({Key? key}) : super(key: key);
  static final Store _stroe = Store("乡村基(瑞福路店)", "重庆市渝北区龙兴镇和合家园C组团瑞福路24号楼45号45-1", [Store.image("head1"), Store.image("head2"),], "09:30-22:00", "盖浇饭/其他快餐",);

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}

class Store {

  final String name;
  final String location;
  final List<Image> pictures;
  final String businessHours;
  final String businessScope;
  Store(this.name, this.location, this.pictures, this.businessHours, this.businessScope);

  static Image image(String name) {
    String eCloudUrl = "https://pub.evlic.cloud/coding/flutter-demo/elm/$name.jpg";
    return Image.network(eCloudUrl, filterQuality: FilterQuality.high);
  }
}

