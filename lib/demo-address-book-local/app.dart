import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'address_home.dart';

class AddressBookApp extends StatelessWidget {
  const AddressBookApp({Key? key}) : super(key: key);

  static String title = "Gopher 通讯录";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
        future: _asyncBuildAppUI(context),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Future<Widget> _asyncBuildAppUI(BuildContext context) async {
    return AbHomeLocal(title);
  }
}
