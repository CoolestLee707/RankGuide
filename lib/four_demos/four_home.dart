import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './model/communityModel.dart';
import 'dart:async';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  List<recommendEntryModel> _communityList = [];

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  requestData() async {
    Response response;
    Dio dio = Dio();
    response = await dio.get(recommendEntryModel().commendUrl());
    print(recommendEntryModel().commendUrl());
    // print('----------');
    // print(response.data['data']['items']);
    // print('----------');
    // print(_communityList);
    setState(() {
      _communityList = (response.data['data']['items'] as List)
          .map((item) => recommendEntryModel.fromJson(item['entry']))
          .toList();
    });
    _refreshController.refreshCompleted();

  }

  Widget _listItemBuilder(BuildContext context, int index) {
    recommendEntryModel model = _communityList[index];
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserInfo(
            usermodel: model.author,
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Text(
              model.content,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w300,
                fontSize: 16.0,
              ),
            ),
          ),
          ContentPhotos(
            model: model,
          ),
          BottomContent(
            model: model,
          ),
          Container(
            height: 10.0,
            color: Colors.grey[100],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    requestData();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: _refreshController,
      onRefresh: requestData,
      child: ListView.builder(
        itemCount: _communityList.length,
        itemBuilder: _listItemBuilder,
      ),
    );
  }
}

///用户信息
class UserInfo extends StatelessWidget {
  authorModel usermodel;
  UserInfo({
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

// 照片
class ContentPhotos extends StatelessWidget {
  recommendEntryModel model;
  ContentPhotos({
    this.model,
  });

  List<Widget> _photosList(double photoW) {
    List<Widget> list = [];

    if (model.images.length == 1) {
      list.add(ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
            height: photoW,
            width: photoW,
            child: Image.network(
              model.images[0],
              fit: BoxFit.cover,
            )),
      ));
      return list;
    }

    if (model.images.length <= 3) {
       for (var i = 0; i < model.images.length; i++) {
        list.add(ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
                color: Colors.white,
                height: photoW,
                width: photoW,
                child: Image.network(
                  model.images[i],
                  fit: BoxFit.cover,
                )),
          ));
          if (i < 2) {
            list.add(SizedBox(width: 2.0,));
          }
      }
      return list;
    }

    for (var i = 0; i < 3; i++) {
      list.add(ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
              color: Colors.white,
              height: photoW,
              width: photoW,
              child: Image.network(
                model.images[i],
                fit: BoxFit.cover,
              )),
        ));
        if (i < 2) {
          list.add(SizedBox(width: 2.0,));
        }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    if (this.model.images.length == 0) {
      return SizedBox(
        height: 10.0,
      );
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
      child: Container(
        color: this.model.images.length > 1 ? Colors.white : Colors.white,
        height: this.model.images.length == 1
            ? 220.0
            : (MediaQuery.of(context).size.width - 34) / 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _photosList(this.model.images.length == 1
              ? 220.0
              : (MediaQuery.of(context).size.width - 34) / 3),
        ),
      ),
    );
  }
}

class BottomContent extends StatelessWidget {
  recommendEntryModel model;
  BottomContent({
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
      child: Container(
        height: 40.0,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              this.model.recommendReason ?? '热门动态',
              style: TextStyle(fontSize: 13.0, color: Colors.black54),
            ),
            Text(
              '${this.model.viewCount}人浏览',
              style: TextStyle(fontSize: 12.0, color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
