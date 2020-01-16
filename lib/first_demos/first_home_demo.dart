import 'package:flutter/material.dart';

class FirstWidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FirstWidgetDemo'),
        elevation: 0.0,
      ),
      body: Center(
        child: Text('1'),
      ),
    );
  }
}