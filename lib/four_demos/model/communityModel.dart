import 'dart:convert';

class recommendEntryModel {
  
    String recommendid;
    List<String>images;
    authorModel author;
    String content;
    String recommendReason;
    int viewCount;//浏览数

    recommendEntryModel({
      this.recommendid,
      this.images,
      this.author,
      this.content,
      this.recommendReason,
      this.viewCount
    });

    recommendEntryModel.fromJson(Map json)
      : recommendid = json['id'],
        images = (json['images'] as List).map((item) {
          return (item as String);
        }).toList(),
        content = json['content'],
        recommendReason = json['recommendReason'],
        viewCount = json['viewCount'],
        author = authorModel.fromJson(json['author']);



//动态url
    String commendUrl () {
      return 'https://api.gotokeep.com/feed/v1/feed/list?feedId=&feedType=sports&limit=6&needCommentInfo=0&needFavoriteInfo=1&needLikeInfo=1&needRelationInfo=1&sort=byTime';
    }
}


// 用户model
class authorModel {
  String avatar;//头像
  String username;
  String desc;//描述
  String verifiedIconUrl = '';//加v
  String uesrid;

  authorModel({
    this.avatar,
    this.username,
    this.desc,
    this.verifiedIconUrl,
    this.uesrid
  });

  authorModel.fromJson(Map json)
    : avatar = json['avatar'],
      username = json['username'],
      desc = json['desc'],
      verifiedIconUrl = json['verifiedIconUrl'],
      uesrid = json['uesrid'];
}






 



