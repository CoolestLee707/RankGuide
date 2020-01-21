import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import './model/community_detailsMode.dart';
import 'model/communityModel.dart';

class FourDetails extends StatelessWidget {
  String itemCategoryId;
  FourDetails({
    this.itemCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动态详情'),
        elevation: 3.0,
        backgroundColor: Colors.blueGrey[400],
      ),
      body: CommunityDetails(itemCategoryId: this.itemCategoryId),
    );
  }
}

class CommunityDetails extends StatefulWidget {
  String itemCategoryId;
  CommunityDetails({
    this.itemCategoryId,
  });

  @override
  _CommunityDetailsState createState() => _CommunityDetailsState();
}

class _CommunityDetailsState extends State<CommunityDetails> {

  detailModel model;

  Future<detailModel> requestData() async {
    Response response;
    Dio dio = Dio();
    response =
        await dio.get(detailModel().commendDetailUrl(widget.itemCategoryId));
    // print(detailModel().commendDetailUrl(widget.itemCategoryId));
    // print('----------');
    // print(response.data['data']);
    model = detailModel.fromJson(response.data['data']);
    return model;
    // setState(() {
    //   model = detailModel.fromJson(response.data['data']);
    // });
  }

  @override
  void initState() {
    super.initState();
    // requestData();
  }

  @override
  Widget build(BuildContext context) {
    
   return FutureBuilder(
     future: requestData(),
     builder: (BuildContext context, AsyncSnapshot snapshot) {
       if (snapshot.connectionState == ConnectionState.waiting) {
         return Center(
           child: Column(
             children: <Widget>[
               Icon(Icons.access_time),
               Text('加载中。。。。'),
             ],
           ),
         );
       }
       return ListView(
        //  children: snapshot.data,
        children: <Widget>[
          detailUserInfo(usermodel: snapshot.data.author,),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              snapshot.data.content,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18.0,

              ),
            ),
          ),
          detailPhotos(photosList: this.model.images,),

        ],
       );

     },

   );
  }
}


class detailPhotos extends StatelessWidget {

  List<String>photosList;
  detailPhotos({
    this.photosList,
  });

  @override
  Widget build(BuildContext context) {

    if (this.photosList.length == 0) {
        return Container(
          child: Text('图片加载中'),
        );
    }

   double photoWH = (MediaQuery.of(context).size.width - 34) / 3;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      
      child: Wrap(
        spacing: 1.0,
        runSpacing: 1.0,
        children: this.photosList.map((item) {
         return ClipRRect(
           borderRadius: BorderRadius.circular(5.0),
           child: Container(
             width: photoWH,
             height: photoWH,
             child: Image.network(
               item,
               fit: BoxFit.cover,
             ),
           )
         );
        }).toList(),
      ),
    );
  }
}

class detailUserInfo extends StatelessWidget {
  authorModel usermodel;
  detailUserInfo({
    this.usermodel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        height: 50.0,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.network(this.usermodel.avatar),
                ),
                Positioned(
                    right: 0.0,
                    bottom: 0.0,
                    child: Container(
                      height: 16.0,
                      width: 16.0,
                      child:
                          Image.network(this.usermodel.verifiedIconUrl ?? ''),
                    ))
              ],
            ),
            SizedBox(
              width: 12.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.usermodel.username,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Text(
                  this.usermodel.desc,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}