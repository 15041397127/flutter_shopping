import 'package:flutter/material.dart';
import '../model/category_goods_list_model.dart';

class CategoryGoodListProvide with ChangeNotifier {
  List<CategoryListData> goodsList = [];

  //点击大类时更换商品列表
  getGoodsList(List<CategoryListData> list) {
    goodsList = list;

    notifyListeners();
  }
}
