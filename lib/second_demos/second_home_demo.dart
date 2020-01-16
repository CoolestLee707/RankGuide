import 'package:flutter/material.dart';
import 'package:flutter_rank_demo/second_demos/rank_category.dart';
import 'package:flutter_rank_demo/second_demos/rank_restaurant.dart';
import 'package:flutter_rank_demo/second_demos/rank_stateful_category.dart';
import 'package:flutter_rank_demo/second_demos/search_home.dart';

class SecondWidgetDemo extends StatelessWidget {
  List<String> _tabs = ['商品榜', '餐馆榜', '医药榜', '汽车榜'];
  List<Widget> _bodys = [FirstBody(), SecondBody(), ThirdBody(), FourBody()];

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
                    builder: (BuildContext context) => SearchHome()
                  ),
                );
              },
            )
          ],
          bottom: TabBar(
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
          ),
        ),
        body: TabBarView(
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
      color: Colors.blueAccent,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            width: 100.0,
            height: 100.0,
            color: Colors.red,
            margin: EdgeInsets.all(30.0),
            // padding: EdgeInsets.all(30.0),
            child: Icon(
              Icons.android,
              size: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}


