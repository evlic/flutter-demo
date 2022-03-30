import 'package:flutter/material.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  _getImg() {
    return Image.asset(
      'resource/img/eason.jpg',
      height: 200,
      width: 200,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('EASON - 无条件'),
        ),
        body: Center(
          child: ClipOval(
            child: _getImg(),
          ),
        ),
      ),
    );
  }
}
