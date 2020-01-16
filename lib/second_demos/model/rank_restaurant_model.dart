// 餐馆榜数据model

import './rank_model.dart';
import 'dart:convert';

class restaurantModel {
  List <cityModel> cities = [];
  String cityCode;
  List <categoriesModel> categories = [];

  restaurantModel({
    this.cities,
    this.cityCode,
    this.categories,
  });

  restaurantModel.fromJson(Map json)
    : cities = (json['cities'] as List).map((item) => cityModel.fromJson(item)).toList(),
      cityCode = json['cityCode'],
      categories = (json['categories'] as List).map((item) => categoriesModel.fromJson(item)).toList();
}


class cityModel {
  String cityId;
  String name;
  String photoUrl;
  String cityCode;
  String location;
  String currency;
  int state;

  cityModel({
    this.cityId,
    this.name,
    this.photoUrl,
    this.cityCode,
    this.location,
    this.currency,
    this.state,
  });

  cityModel.fromJson(Map json)
    : cityId = json['cityId'],
      name = json['name'],
      photoUrl = json['photoUrl'],
      cityCode = json['cityCode'],
      location = json['location'],
      currency = json['currency'],
      state = json['state'];
}

// 种类model
  class categoriesModel {
      String contentId;
      String title;
      List <contentItemsModel> contentItems;
      List <evaluationModel> evaluations;

      categoriesModel({
        this.contentId,
        this.title,
        this.contentItems,
        this.evaluations,
      });

      categoriesModel.fromJson(Map json)
        : contentId = json['contentId'],
          title = json['title'],
          contentItems = (json['contentItems'] as List).map((item) => contentItemsModel.fromJson(item)).toList(),
          evaluations = (json['evaluations'] as List).map((item) => evaluationModel.fromJson(item)).toList();
  }


  class contentItemsModel {
    String targetId;
    String title;
    String subTitle;
    String icon;
    int targetType;

    contentItemsModel({
      this.targetId,
      this.title,
      this.subTitle,
      this.icon,
      this.targetType,
    });

    contentItemsModel.fromJson(Map json)
      : targetId = json['targetId'],
        title = json['title'],
        subTitle = json['subTitle'],
        icon = json['icon'],
        targetType = json['targetType'];
  }

  // 接数据
  class requestResuaurantData {

    String ResuaurantDataUrl (){
      return 'https://zone.guiderank-app.com/guiderank-web/app/city/listCityContentCategories.do?imei=CFE7C998-F55E-4CCC-AD84-375A27B1E59A&role=1&model=iPhone%20XS%20Max%20%28China%29_13.3&token&ver=iOS_3.18.3.c581e71ca';
    }

  }