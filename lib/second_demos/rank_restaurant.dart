import 'package:flutter/material.dart';
import './model/rank_restaurant_model.dart';
import 'package:dio/dio.dart';
import 'dart:async';
 
// 餐馆榜
class RankRestaurant extends StatefulWidget {
  @override
  _RankRestaurantState createState() => _RankRestaurantState();
}

class _RankRestaurantState extends State<RankRestaurant> {

    int _selectedNuber = 0;
    restaurantModel _restModel;
    List<cityModel> _cityModelList = [];

  @override
  void initState() {
    super.initState();

    requestRestaurantData('010',true);
  }

   Future requestRestaurantData(String cityCode,bool isFirstLoad) async {
    Response response;
    Dio dio = Dio();
    response = await dio.post(requestResuaurantData().ResuaurantDataUrl(),data: {"cityCode": cityCode});
    
    _restModel = restaurantModel.fromJson(response.data['data']);

    setState(() {
      if (isFirstLoad) {
        _cityModelList = _restModel.cities;
      } 
    });
  }

// 点击执行的方法
    selectCategory(int index, String categoryId) {

        setState(() {
          _selectedNuber = index;
        });

      requestRestaurantData(categoryId,false);
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
    if (_cityModelList.length == 0) {
      return Center(
        child: Text('加载中。。。'),
      );
    }
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0.0, 0.0, 10.0),
            color: Colors.white,
            width: 130.0,
            child: ListView.builder(
              itemCount: _cityModelList.length,
              itemBuilder: (BuildContext context, int index) {
              cityModel model = _cityModelList[index];
                return GestureDetector(
                  child: Container(
                  height: 50.0,
                  color: cellcolor(index),
                  padding: EdgeInsets.fromLTRB(20.0, 5.0, 5.0, 5.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.network(model.photoUrl,fit: BoxFit.cover,),
                        SizedBox(width: 10.0,),
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
            selectCategory(index,model.cityCode);
          },
        );
              },
            ),
          ),
        ),
        Expanded(
          child: rankDetailCategory(categoriesModelList: _restModel.categories,),
        ),
      ],
    );
  }
}



class rankDetailCategory extends StatelessWidget {

  List<categoriesModel> categoriesModelList = [];
  rankDetailCategory({
    this.categoriesModelList,
  });

  @override
  Widget build(BuildContext context) {
    if (categoriesModelList.length == 0) {
      return Center(
        child: Text('加载中。。。'),
      );
    }
    return Container(
      color: Colors.grey[100],
      child: ListView.builder(
        itemCount: categoriesModelList.length,
        itemBuilder: (BuildContext context, int index) {
          categoriesModel model = this.categoriesModelList[index];
          return rankCell(
            model: model,
          );
        },
      ),
    );
  }
}

class rankCell extends StatelessWidget {
  categoriesModel model;

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
              this.model.title,
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Recommend(model: this.model,),
            WrapView(
              categories: this.model.contentItems,
            ),
          ],
        ),
      ),
    );
  }
}
// 测评推荐模块，动态有
class Recommend extends StatelessWidget {
  categoriesModel model;

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
  List<contentItemsModel> categories = [];

  WrapView({
    this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: itemBoxs(categories),
    );
  }
}

/*一个渐变颜色的正方形集合*/
List<Widget> itemBoxs(List <contentItemsModel>boxlist) {
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
            model.icon,
            width: 60.0,
            height: 60.0,
          ),
          SizedBox(
            height: 3.0,
          ),
          Text(
            model.subTitle,
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