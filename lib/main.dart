import 'package:flutter/material.dart';
import 'package:meetup/src/home/home_scaffold.dart';

void main() {
  runApp(const MeetupApp());
}

class MeetupApp extends StatelessWidget {
  const MeetupApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const Home(),
    );
  }
}
