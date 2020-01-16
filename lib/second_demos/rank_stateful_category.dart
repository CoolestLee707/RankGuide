import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import './model/rank_model.dart';

// 商品榜-动态
class rankStatufulCategory extends StatefulWidget {
  @override
  _rankStatufulCategoryState createState() => _rankStatufulCategoryState();
}

class _rankStatufulCategoryState extends State<rankStatufulCategory> {
  int _selectedNuber = 0;
  List<categoryModel> _rankCategoryList = [];
  List<itemCategoryModel> _itemCategoryModelList = [];

  @override
  void initState() {
    super.initState();

    requestData();
  }

  requestData() async {
    await fetchData();
    // print('左边数据');
    // print(_rankCategoryList);
    if (_rankCategoryList.length > 0) {
      categoryModel model = _rankCategoryList[0];
      getData(model.categoryId);
    }
  }

// 左边数据
  Future fetchData() async {
    Response response;
    Dio dio = Dio();
    response = await dio.post(rankRequestData().returnUrl(),
        data: {"categoryIds": rankRequestData().returnRequestDataList()});

    FirstRankCategoryQueue queueModel =
        FirstRankCategoryQueue.fromJson(response.data['data']);

    setState(() {
      _rankCategoryList = queueModel.categories;
    });
  }

// 右边数据
  getData(String rootCategoryId) async {
    // print(rootCategoryId);

    Response response;
    Dio dio = Dio();
    response = await dio.post(rankRequestData().returnCategryUrl(),
        data: {"rootCategoryId": rootCategoryId});

    itemBigMode bigMode =
        itemBigMode.fromJson(response.data['data']['rootCategory']);
    // print('右边数据源');

    // print(response);
    // print('-------------');
    // print(bigMode.categories);
    setState(() {
      _itemCategoryModelList = bigMode.categories;
    });
  }

// 点击执行的方法
  selectCategory(int index, String categoryId) {
    setState(() {
      _selectedNuber = index;
    });

    getData(categoryId);
  }

  // 选中颜色
  Color cellcolor(int index) {
    if (index == _selectedNuber) {
      // return Theme.of(context).primaryColor;
      return Colors.yellowAccent;
    }
    return Colors.white;
  }

// 选中字体风格
  TextStyle cellSelectedStyle(int index) {
    if (index == _selectedNuber) {
      return TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      );
    }
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0.0, 0.0, 10.0),
            color: Colors.white,
            width: 130.0,
            child: ListView.builder(
              itemCount: _rankCategoryList.length,
              itemBuilder: (BuildContext context, int index) {
                categoryModel model = _rankCategoryList[index];
                return GestureDetector(
                  child: Container(
                    height: 50.0,
                    color: cellcolor(index),
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.network(model.photoUrl),
                        Text(
                          model.name,
                          style: cellSelectedStyle(index),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    selectCategory(index, model.categoryId);
                    // print(model.name);
                  },
                );
              },
            ),
          ),
        ),
        Expanded(
          child: rankDetailCategory(
            itemCategoryModelList: _itemCategoryModelList,
          ),
        ),
      ],
    );
  }
}

class rankDetailCategory extends StatelessWidget {
  List<itemCategoryModel> itemCategoryModelList = [];
  rankDetailCategory({
    this.itemCategoryModelList,
  });

  @override
  Widget build(BuildContext context) {
    if (itemCategoryModelList.length == 0) {
      return Center(
        child: Text('加载中。。。'),
      );
    }
    return Container(
      color: Colors.grey[100],
      child: ListView.builder(
        itemCount: itemCategoryModelList.length,
        itemBuilder: (BuildContext context, int index) {
          itemCategoryModel model = this.itemCategoryModelList[index];
          return rankCell(
            model: model,
          );
        },
      ),
    );
  }
}

class rankCell extends StatelessWidget {
  itemCategoryModel model;

  rankCell({
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              this.model.name,
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Recommend(model: this.model,),
            WrapView(
              // test
              categories: this.model.categories,
            ),
          ],
        ),
      ),
    );
  }
}

// 测评推荐模块，动态有
class Recommend extends StatelessWidget {
  itemCategoryModel model;

  Recommend({
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    if (this.model.evaluations.length == 0) {
      return SizedBox(
        height: 13.0,
      );
    }
    return Column(
      children: <Widget>[
        SizedBox(
          height: 13.0,
        ),
        Container(
          height: 80.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(5.0, 1.0, 5.0, 1.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blueAccent,
                              Colors.blue,
                              Colors.lightBlue
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7.0),
                            bottomRight: Radius.circular(7.0),
                          ),
                        ),
                        child: Text(
                          '测评推荐',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 3.0),
                      Text(
                        this.model.evaluations[0].title,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Flexible(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: Image.network(
                      model.evaluations[0].photoUrls,
                      width: 60.0,
                      height: 60.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 8.0,),
      ],

    );
  }
}

class WrapView extends StatelessWidget {
  List<itemModel> categories = [];

  WrapView({
    this.categories,
  });

  @override
  Widget build(BuildContext context) {
    // print('----- ${MediaQuery.of(context).size.width}');//屏幕宽高
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: itemBoxs(categories),
    );
  }
}

/*一个渐变颜色的正方形集合*/
List<Widget> itemBoxs(List boxlist) {
  return boxlist.map((model) {
    return Container(
      width: 82,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.white, Colors.white]),
          borderRadius: BorderRadius.circular(7.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            model.photoUrl,
            width: 60.0,
            height: 60.0,
          ),
          SizedBox(
            height: 3.0,
          ),
          Text(
            model.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }).toList();
}
