// // import 'package:edu_flutter_login_save/demo-music-player/var.dart';
// import 'package:flutter/material.dart';
//
// class MusicList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark(),
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Music List')),
//         body: _List(),
//       ),
//     );
//   }
// }
//
// class _List extends StatelessWidget {
//   List<Widget> _getList() {
//     var cnt = 0;
//     var res = DATA.map((value) {
//       return Container(
//         child: Column(
//           children: <Widget>[
//             Text('「${cnt++}」'),
//             Text(value["ctx"] as String),
//             Text(value['author'] as String),
//             Text(value['icon'] as String),
//           ],
//         ),
//       );
//     });
//
//     return res.toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // ignore: sized_box_for_whitespace
//     return Container(
//         height: 700,
//         child: ListView(
//           children: _getList(),
//         ));
//   }
// }
