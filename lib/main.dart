import 'package:day9_task/screens/home.dart';
import 'package:day9_task/screens/tvShows.dart';
import 'package:day9_task/screens/settings.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // home: TabBarExample()
      // BottomNavigationBarDemo(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        'tvShows': (context) => TVShowsListPage(),
        'settings': (context) => SettingPage(),
      },
    );
  }
}
