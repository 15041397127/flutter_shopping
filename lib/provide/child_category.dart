import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  //点击按下状态管理  高亮索引
  int chilidIndex = 0;

  //左侧大类ID 默认为4
  String categoryId = '4';

  //小类id
  String categorysubId = '';

  int page = 1; //列表分页

  String noMoreTest = ''; //上拉加载属性 显示没有数据的占位文字

  getChildCategory(List<BxMallSubDto> list, String categoryBidId) {
    //每次点击左侧大类 都置为0
    chilidIndex = 0;
    categoryId = categoryBidId;
    page = 1; //切换大类 默认页数为1
    noMoreTest = '';
    BxMallSubDto bxMallSubDto = BxMallSubDto();

    bxMallSubDto.mallSubId = '00';
    bxMallSubDto.mallCategoryId = '00';
    bxMallSubDto.comments = 'null';
    bxMallSubDto.mallSubName = '全部';

    childCategoryList = [bxMallSubDto];

    childCategoryList.addAll(list);
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(index, String subId) {
    page = 1; //切换大类 默认页数为1
    noMoreTest = '';
    chilidIndex = index;
    categorysubId = subId;
    notifyListeners();
  }

  //上拉加载增加page值
  addPage() {
    page++;
//    notifyListeners();
  }

  changeNoMoreText(String text) {
    noMoreTest = text;
    notifyListeners();
  }
}
