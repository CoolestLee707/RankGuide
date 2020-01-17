import 'dart:convert';
import 'package:flutter/material.dart';

class searchkeysModel {
  List<String>keywords;
  searchkeysModel({
    this.keywords,
  });

  searchkeysModel.fromJson(Map json) {
    this.keywords = (json['keywords'] as List).map((item) {
      return (item as String);
    }).toList();
  }
}

class searchKeysUrl {

  String returnUrl () {
    return 'https://zone.guiderank-app.com/guiderank-web/app/common/listSearchKeywordByScene.do?imei=CFE7C998-F55E-4CCC-AD84-375A27B1E59A&role=1&model=iPhone%20XS%20Max%20%28China%29_13.3&token&ver=iOS_3.18.3.c581e71ca';
  }
}