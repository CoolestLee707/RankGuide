import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'model/rank_search_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SearchHome extends StatefulWidget {
  int sceneItemNumber = 3;

  SearchHome({
    this.sceneItemNumber,
  });

  @override
  _SearchHomeState createState() => _SearchHomeState();
}

class _SearchHomeState extends State<SearchHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
        elevation: 0.0,
      ),
      body: MainBody(
        selectNumber: widget.sceneItemNumber,
      ),
    );
  }
}

class MainBody extends StatefulWidget {
  int selectNumber;

  MainBody({
    this.selectNumber,
  });
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  searchkeysModel keysModel;
  String _selectButton = '';
  List<String> _buttonTextList = ['商品榜', '美食榜', '医药榜', '汽车榜'];
  List<String> allSearchTextList = [];
  List<String> HistorySearchTextList = [];

  requestData(int scene) async {
    Response response;
    Dio dio = Dio();
    response =
        await dio.post(searchKeysUrl().returnUrl(), data: {"scene": scene});

    keysModel = searchkeysModel.fromJson(response.data['data']);

    // 读取历史搜索
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      allSearchTextList = keysModel.keywords;
      HistorySearchTextList = prefs.getStringList('search_history') ?? [];
    });
  }

  selectButtonStyle(String item) {
    if (item == _selectButton) {
      return TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.blue[200],
      );
    }
    return TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );
  }

  @override
  void initState() {
    super.initState();
    requestData(widget.selectNumber);
    switch (widget.selectNumber) {
      case 3:
        _selectButton = _buttonTextList[0];
        break;
      case 4:
        _selectButton = _buttonTextList[1];
        break;
      case 7:
        _selectButton = _buttonTextList[2];
        break;
      case 8:
        _selectButton = _buttonTextList[3];
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    String _searchKeys;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        height: 40.0,
                        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        color: Colors.white,
                        child: TextField(
                          // 设置键盘类型右下角按键
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '输入搜索关键字',
                            icon: Icon(
                              Icons.search,
                              color: Colors.black87,
                            ),
                          ),
                          onChanged: (value) {
                            _searchKeys = value;
                          },

                          ///键盘上按了done
                          onSubmitted: (value) async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            this.HistorySearchTextList = prefs.getStringList('search_history') ?? [];
                              setState(() {
                                this.HistorySearchTextList.add(value);
                              });
                            prefs.setStringList('search_history', this.HistorySearchTextList);
                            FocusScope.of(context).requestFocus(FocusNode());

                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('search ${value}。。。'),
                                action: SnackBarAction(
                                  label: 'OK',
                                  onPressed: (){

                                  },
                                ),
                              )
                            );
                            
                          },
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: FlatButton(
                      child: Text(
                        '取消',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.grey[100],
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _buttonTextList.map((item) {
                    return FlatButton(
                      child: Text(
                        item,
                        style: selectButtonStyle(item),
                      ),
                      onPressed: () {
                        setState(() {
                          _selectButton = item;
                          int selectItem = 3;
                          if (item == _buttonTextList[0]) {
                            selectItem = 3;
                          } else if (item == _buttonTextList[1]) {
                            selectItem = 4;
                          } else if (item == _buttonTextList[2]) {
                            selectItem = 7;
                          } else {
                            selectItem = 8;
                          }
                          requestData(selectItem);
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              SearchTips(
                allSearchTextList: this.allSearchTextList,
                historySearchTextList: this.HistorySearchTextList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchTips extends StatelessWidget {
  List<String> allSearchTextList;
  List<String> historySearchTextList;

  SearchTips({this.allSearchTextList, this.historySearchTextList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          AllPeopleSearch(
            allSearchTextList: this.allSearchTextList,
          ),
          HistorySearch(
            historySearchTextList: this.historySearchTextList,
          ),
        ],
      ),
    );
  }
}

class AllPeopleSearch extends StatelessWidget {
  List<String> allSearchTextList;

  AllPeopleSearch({
    this.allSearchTextList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Text(
            '大家都在搜',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18.0,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Wrap(
            spacing: 15.0,
            runSpacing: 4.0,
            children: this.allSearchTextList.map((item) {
              return ActionChip(
                label: Text(item),
                onPressed: () {
                  print(item);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class HistorySearch extends StatefulWidget {
  List<String> historySearchTextList;
  HistorySearch({
    this.historySearchTextList,
  });

  @override
  _HistorySearchState createState() => _HistorySearchState();
}

class _HistorySearchState extends State<HistorySearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '历史搜索',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: FlatButton.icon(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: Text(
                    '清空',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400),
                  ),
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove('search_history');

                    setState(() {
                      widget.historySearchTextList = [];
                    });
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Wrap(
            spacing: 15.0,
            runSpacing: 4.0,
            children: widget.historySearchTextList.map((item) {
              return ActionChip(
                label: Text(item),
                onPressed: () {
                  print(item);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
