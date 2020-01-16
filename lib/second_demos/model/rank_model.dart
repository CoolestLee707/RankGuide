// 商品榜model
class FirstRankCategoryQueue {
  List<categoryModel> categories = [];

  FirstRankCategoryQueue({
    this.categories,
  });

  FirstRankCategoryQueue.fromJson(Map json)
    : categories = (json['categories'] as List).map((item) => categoryModel.fromJson(item)).toList();
}

class categoryModel {
  String categoryId;
  String name;
  String photoUrl;
  String alias;
  String yanXuanPhotoUrl;
  String buttonPhotoUrl;
  int type;
  int version;
  int categoryType;

  categoryModel({
    this.categoryId,
    this.name,
    this.photoUrl,
    this.alias,
    this.yanXuanPhotoUrl,
    this.buttonPhotoUrl,
    this.type,
    this.version,
    this.categoryType,
  });

  categoryModel.fromJson(Map json)
      : categoryId = json['categoryId'],
        name = json['name'],
        photoUrl = json['photoUrl'],
        alias = json['alias'],
        yanXuanPhotoUrl = json['yanXuanPhotoUrl'],
        buttonPhotoUrl = json['buttonPhotoUrl'],
        type = json['type'],
        version = json['version'],
        categoryType = json['categoryType'];
}

// ===============================种类数据


// 外层model
class itemBigMode {
  String categoryId;
  String name;
  String photoUrl;
  int type;
  int version;
  int categoryType;
  List<itemCategoryModel> categories = [];
  String buttonPhotoUrl;

  itemBigMode({
    this.categoryId,
    this.name,
    this.photoUrl,
    this.type,
    this.version,
    this.categoryType,
    this.categories,
    this.buttonPhotoUrl,
  });

  itemBigMode.fromJson(Map json)
    : categoryId = json['categoryId'],
      name = json['name'],
      photoUrl = json['photoUrl'],
      type = json['type'],
      version = json['version'],
      categoryType = json['categoryType'],
      categories = (json['categories'] as List).map((item) => itemCategoryModel.fromJson(item)).toList(),
      buttonPhotoUrl = json['buttonPhotoUrl'];
}
//中间model
class itemCategoryModel {
  String categoryId;
  String name;
  String photoUrl;
  int type;
  int version;
  int categoryType;
  List<itemModel> categories = [];
  List<evaluationModel> evaluations = [];

  itemCategoryModel({
    this.categoryId,
    this.name,
    this.photoUrl,
    this.type,
    this.version,
    this.categoryType,
    this.categories,
    this.evaluations,
  });

  itemCategoryModel.fromJson(Map json)
    : categoryId = json['categoryId'],
      name = json['name'],
      photoUrl = json['photoUrl'],
      type = json['type'],
      version = json['version'],
      categoryType = json['categoryType'],
      categories = (json['categories'] as List).map((item) => itemModel.fromJson(item)).toList(),
      evaluations = (json['evaluations'] as List).map((item) => evaluationModel.fromJson(item)).toList();
}

// -----------------表头说明-广告
class evaluationModel {
  String evaluationId;
  String title;
  String goodsTitle;
  int createTime;
  int publishTime;
  bool top;
  num price;
  String photoUrls;
  String firstCategoryId;
  num couponOff;
  num cashback;
  int userType;
  String subTitle; 

  evaluationModel({
    this.evaluationId,
    this.title,
    this.goodsTitle,
    this.createTime,
    this.publishTime,
    this.top,
    this.price,
    this.photoUrls,
    this.firstCategoryId,
    this.couponOff,
    this.cashback,
    this.userType,
    this.subTitle,
  }); 

  evaluationModel.fromJson(Map json)
    : evaluationId = json['evaluationId'],
      title = json['title'],
      goodsTitle = json['goodsTitle'],
      createTime = json['createTime'],
      publishTime = json['publishTime'],
      top = json['top'],
      price = json['price'],
      photoUrls = (json['photoUrls'] as List)[0],
      firstCategoryId = json['firstCategoryId'],
      couponOff = json['couponOff'],
      cashback = json['cashback'],
      userType = json['userType'],
      subTitle = json['subTitle'];
}
// -----------------最里面model
class itemModel {
  String categoryId;
  String name;
  String photoUrl;
  int type;
  int version;
  int categoryType;

  itemModel({
    this.categoryId,
    this.name,
    this.photoUrl,
    this.type,
    this.version,
    this.categoryType,
  });

  itemModel.fromJson(Map json)
    : categoryId = json['categoryId'],
      name = json['name'],
      photoUrl = json['photoUrl'],
      type = json['type'],
      version = json['version'],
      categoryType = json['categoryType'];
}

// -------------------------------------------接口
class rankRequestData {

  String returnUrl () {
    return 'https://zone.guiderank-app.com/guiderank-web/app/ranking/getFirstCategoryQueueByUser.do?imei=CFE7C998-F55E-4CCC-AD84-375A27B1E59A&role=1&model=iPhone%20XS%20Max%20%28China%29_13.3&token&ver=iOS_3.18.1.e90c18934';
  }

  String returnCategryUrl () {
    return 'https://zone.guiderank-app.com/guiderank-web/app/ranking/getRootCategoryById.do?imei=CFE7C998-F55E-4CCC-AD84-375A27B1E59A&role=1&model=iPhone%20XS%20Max%20%28China%29_13.3&token&ver=iOS_3.18.1.e90c18934';
  	  // return 'https://zone.guiderank-app.com/guiderank-web/app/ranking/getRootCategoryById.do?imei=CFE7C998-F55E-4CCC-AD84-375A27B1E59A&role=1&model=iPhone%20XS%20Max%20%28China%29_13.3&token&ver=iOS_3.18.3.c581e71ca';
  }

  List<String> returnRequestDataList() {
    return [
      "14715038009902448788",
      "14893893411517414535",
      "14606196569909140356",
      "14891349711518013320",
      "15514115871503319048",
      "14963845471510210686",
      "14720215729915071523",
      "14715111749905086629",
      "14901699881521428094",
      "14606198429909563672",
      "14677105269901537340",
      "14606907939908032283",
      "14606901169902745764",
      "14824593311500827298",
      "14606912729911500882",
      "14606185549903426848",
      "14606878159914652423",
      "14888776511549513601",
      "14606872029911102868",
      "14764107321551813741",
      "14606912629911486608",
      "14606191669905626622",
      "15047525721526988682",
      "14984470991512015819",
      "14677126939909738082",
      "14842979901505313230",
      "14715113669905280732",
      "14824593021500492073",
      "14881771321594294256",
      "14851407551502409881",
      "14606904539905217132",
      "14606902309903588541",
      "14606203319911832512",
      "14606256409901012687",
      "14721957999904512383",
      "14841868611502469566",
      "14606912999911829655",
      "14901730481516360107",
      "15115151871550993364",
      "14850504991514656240",
      "14606201179911150455",
      "14873220161503696650",
      "14682186839900012475",
      "14811822531577163366",
      "14986191471509822950",
      "14948213081512867908",
      "14606207929913157013",
      "14606894949920136925",
      "14839445961545411992",
      "14720952879900657492"
    ];
  }
}
