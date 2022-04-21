import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
}
