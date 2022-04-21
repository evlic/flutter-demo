import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressBookApp extends StatelessWidget {
  const AddressBookApp({Key? key}) : super(key: key);

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
        }
    );
  }

  Future<Widget> _asyncBuildAppUI(BuildContext context) async {
    return context.widget;
  }
}
