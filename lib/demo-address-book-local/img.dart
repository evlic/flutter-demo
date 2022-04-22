import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../demo-elm/css.dart';
import 'item.dart';

class Images {
  static final Image got =
      Image.network("https://pub.evlic.cloud/icon/GOT_Gopher.png");
  static final Image vik =
      Image.network("https://pub.evlic.cloud/icon/GOPHER_VIKING.png");
  static final Image parakeet =
      Image.network("https://pub.evlic.cloud/icon/GOPHER_PARAKEET.png");
  static final Image edward =
      Image.network("https://pub.evlic.cloud/icon/GOPHER_EDWARD.png");
  static final Image academy =
      Image.network("https://pub.evlic.cloud/icon/GOPHER%20ACADEMY.png");
  static final List<Image> images = [got, vik, parakeet, edward, academy];

  static final List<String> imageUrl = [
    "https://pub.evlic.cloud/icon/GOT_Gopher.png",
    "https://pub.evlic.cloud/icon/GOPHER_VIKING.png",
    "https://pub.evlic.cloud/icon/GOPHER_PARAKEET.png",
    "https://pub.evlic.cloud/icon/GOPHER_EDWARD.png",
    "https://pub.evlic.cloud/icon/GOPHER%20ACADEMY.png",
  ];


  static Widget buildAvatar(User user) {
    late Image res;
    var r = -1;
    for (var i = 0; i < Images.imageUrl.length; i++) {
      if (Images.imageUrl[i] == user.avatarUrl) {
        r = i;
        break;
      }
    }

    if (r == -1) {
      r = Random().nextInt(Images.images.length);
    }

    user.avatarUrl = Images.imageUrl[r];
    res = Images.images[r];

    // todo 包装
    return Expanded(
      flex: 2,
      child: Container(
        padding: ComEdge.defAllEdge20,
        margin: ComEdge.defAllEdge20,
        child: ClipOval(
            child: res
        ),
      ),
    );
  }
}
