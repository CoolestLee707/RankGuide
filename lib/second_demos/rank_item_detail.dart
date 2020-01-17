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
      ),
    );
  }
}
