import 'dart:io';

import 'toast.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

// 获取一个可以读写的文件对象
Future<File> getLocalFile(String name) async {
  final path = await _localPath;
  return File('$path/name');
}

// 写入 string
Future<File> write({String name = 'tmp', required String json}) async {
  final file = await getLocalFile(name);

  // Write the file
  return file.writeAsString(json);
}

class ReadState {
  static const String error = "";
}

// 读取 String
Future<String> read({String name = 'tmp'}) async {
  try {
    final file = await getLocalFile(name);

    // Read the file
    final json = await file.readAsString();

    return json;
  } catch (e) {
    // If encountering an error, return 0
    logMsg(msg: "文件未被创建, 将会在您初次提交后保存信息到文件中.");
    return ReadState.error;
  }
}