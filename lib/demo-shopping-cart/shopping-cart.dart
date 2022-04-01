import 'package:flutter/material.dart';

class ShoppingCartApp extends StatefulWidget {
  const ShoppingCartApp({Key? key}) : super(key: key);

  @override
  createState() => CartState();
}

class Ware {
  const Ware(
    this.image,
    this.wareTitle,
    this.tradeName,
  );

  // 商品图片
  final Image image;
  // 商品名称
  final String wareTitle;
  // 商家名称
  final String tradeName;
}

class CartState extends State<ShoppingCartApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
