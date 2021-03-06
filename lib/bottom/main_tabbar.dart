import 'package:flutter/material.dart';
import 'package:flutter_rank_demo/first_demos/first_home_demo.dart';
import 'package:flutter_rank_demo/four_demos/four_home.dart';
import 'package:flutter_rank_demo/second_demos/second_home_demo.dart';

class MainBottomNavigation extends StatefulWidget {
  @override
  _MainBottomNavigationState createState() => _MainBottomNavigationState();
}

class _MainBottomNavigationState extends State<MainBottomNavigation> {

  List<Widget> tabbarList = List();
  int _currentIndex = 0;

  @override
  void initState() { 
    super.initState();
    
    tabbarList
      ..add(FirstWidgetDemo())
      ..add(SecondWidget())
      ..add(ThirdWidgetDemo())
      ..add(FourWidgetDemo())
      ..add(FiveWidgetDemo());
  }

  void _onTapHandler(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabbarList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        currentIndex: _currentIndex,
        onTap: _onTapHandler,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('首页')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text('榜单')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            title: Text('特价')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_compact),
            title: Text('社区')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            title: Text('我的')
          ),
        ],
      ),
    );
  }
}






class ThirdWidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ThirdWidgetDemo'),
        elevation: 0.0,
      ),
      body: Center(
        child: Text('3'),
      ),
    );
  }
}

class FourWidgetDemo extends StatelessWidget {

  @override
  Size get PreferredSize {
    return Size.fromHeight(30.0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MAppBar(
        child: Container(
          height: 44.0,
          color: Colors.blueGrey[400],
        ),
      ),
      body: Community(),
    );
  }
}

// 自定义导航栏
class MAppBar extends StatefulWidget implements PreferredSizeWidget {

  final Widget child;
  MAppBar({
    this.child,
  });
  @override
  Size get preferredSize {
    return new Size.fromHeight(44.0);
  }
  @override
  State createState() {
    return new MAppBarState();
  }
}

class MAppBarState extends State<MAppBar> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}


class FiveWidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FiveWidgetDemo'),
        elevation: 0.0,
      ),
      body: Center(
        child: Text('5'),
      ),
    );
  }
}