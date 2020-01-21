import 'dart:convert';

import 'communityModel.dart';

class detailModel {
  String content;
  authorModel author;
  List<String>images;

  detailModel({
    this.content,
    this.author,
    this.images,
  });

  detailModel.fromJson(Map json)
    : content = json['content'],
      images = (json['images'] as List).map((item) {
          return (item as String);
        }).toList(),
      author = authorModel.fromJson(json['author']);

//动态详情url
    String commendDetailUrl (String itemId) {
      return 'https://api.gotokeep.com/community/v1/entries/${itemId}?reverse=true';
    }
}
