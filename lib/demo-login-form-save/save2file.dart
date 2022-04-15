import 'dart:io';

import 'package:edu_flutter_login_save/util/toast.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

// 获取一个可以读写的文件对象
Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/tmp.json');
}

// 写入 string
Future<File> write(String json) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsString(json);
}

class ReadState {
  static const String error = "";
}


// 读取 String
Future<String> read() async {
  try {
    final file = await _localFile;

    // Read the file
    final json = await file.readAsString();

    return json;
  } catch (e) {
    // If encountering an error, return 0
    logMsg(msg: "read error >> $e");
    return "";
  }
}