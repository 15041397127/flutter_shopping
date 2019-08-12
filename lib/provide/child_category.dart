import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  getChildCategory(List<BxMallSubDto> list) {

    BxMallSubDto bxMallSubDto = BxMallSubDto();

    bxMallSubDto.mallSubId = '00';
    bxMallSubDto.mallCategoryId = '00';
    bxMallSubDto.comments = 'null';
    bxMallSubDto.mallSubName = '全部';

    childCategoryList = [bxMallSubDto];

    childCategoryList.addAll(list);
    notifyListeners();
  }
}
