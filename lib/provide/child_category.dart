import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  //点击按下状态管理  高亮索引
  int chilidIndex = 0;

  getChildCategory(List<BxMallSubDto> list) {
    //每次点击左侧大类 都置为0
    chilidIndex = 0;
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
  changeChildIndex(index) {
    chilidIndex = index;
    notifyListeners();
  }
}
