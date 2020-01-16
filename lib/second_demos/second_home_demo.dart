import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rank_demo/second_demos/rank_category.dart';
import 'package:flutter_rank_demo/second_demos/rank_restaurant.dart';
import 'package:flutter_rank_demo/second_demos/rank_stateful_category.dart';
import 'package:flutter_rank_demo/second_demos/search_home.dart';

class SecondWidget extends StatefulWidget {
  @override
  _SecondWidgetState createState() => _SecondWidgetState();
}

// SingleTickerProviderStateMixin ！！！

class _SecondWidgetState extends State<SecondWidget> with SingleTickerProviderStateMixin {

  List<String> _tabs = ['商品榜', '餐馆榜', '医药榜', '汽车榜'];
  List<Widget> _bodys = [FirstBody(), SecondBody(), ThirdBody(), FourBody()];

  int _selectItemNumber = 3;

  TabController tabController;

  @override
  void initState() { 
    super.initState();
    
    tabController = TabController(vsync: this,length: _tabs.length)
    ..addListener((){
      switch (tabController.index) {
        case 0:
          _selectItemNumber = 3;
          break;
        case 1:
          _selectItemNumber = 4;
          break;
        case 2:
          _selectItemNumber = 7;
          break;
        case 3:
          _selectItemNumber = 8;
          break;
        default:
      }
    });
  }
    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('榜单'),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => SearchHome(sceneItemNumber: _selectItemNumber,)
                  ),
                );
              },
            )
          ],
          bottom: TabBar(
            controller: tabController,
            unselectedLabelColor: Colors.black87,
            unselectedLabelStyle:
                TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
            labelStyle: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 5.0,
            labelColor: Colors.black,
            tabs: _tabs.map((String title) {
              return Text(title);
            }).toList(),
            onTap: (int selected){
       
            },
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: _bodys,
        ),
      ),
    );
  }
}

class FirstBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: rankStatufulCategory(),
    );
  }
}

class SecondBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: RankRestaurant(),
    );
  }
}

class ThirdBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: rankStatufulCategory(),
    );
  }
}

class FourBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: rankStatufulCategory(),
    );
  }
}


