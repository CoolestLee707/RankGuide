import 'package:flutter/material.dart';

class RankItemDetail extends StatefulWidget {

  @required String itemCategoryId;
  RankItemDetail({
    this.itemCategoryId,
  });

  @override
  _RankItemDetailState createState() => _RankItemDetailState();
}

class _RankItemDetailState extends State<RankItemDetail> {

  String _testString = '1';
// 传递函数。类似block
  void _handleTapboxChanged(String newValue) {
    setState(() {
      _testString = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {

    @override
    void initState() { 
      super.initState();
      
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('RankItemDetail'),
        elevation: 0.0,
        actions: <Widget>[
            IconButton(
                icon: Icon(Icons.share),
                tooltip: 'Share',
                onPressed: () {
               
              },
            )
          ],
      ),
      body: testW(active: _testString,onChanged: _handleTapboxChanged,),
    );
  }
}

class testW extends StatelessWidget {

  final String active;
  final ValueChanged<String> onChanged;

  testW({
    this.active = '0',
    @required this.onChanged,
  });
  void _handleTap() {
    // 调用传来的函数
    onChanged('123');
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        child: Text(this.active),
        onPressed: _handleTap,
      ),
    );
  }
}