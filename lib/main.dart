import 'package:flutter/material.dart';
import 'package:flutter_rank_demo/bottom/main_tabbar.dart';

void main() => runApp(rankApp());

class rankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[100],
        splashColor: Colors.yellow,
        accentColor: Colors.black,
        // highlightColor: Colors.red,
      ),

      initialRoute: '/',
      routes: {
        '/' : (context) => MainBottomNavigation(),
      },
    );
  }
}