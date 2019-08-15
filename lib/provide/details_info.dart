import 'package:flutter/material.dart';
import '../model/details_model.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailInfoProvide with ChangeNotifier {
  DetailsModel goodsInfor = DetailsModel();

  //控制商品详情
  bool isLeft = true;

  //控制评论
  bool isRight = false;

  //从后台获取数据

  getGoodsInfor(String id) async {
    var formData = {'goodId': id};

    await request('getGoodDetailById', formData: formData).then((val) {
      var responsData = json.decode(val.toString());

      print(responsData);

      goodsInfor = DetailsModel.fromJson(responsData);
      notifyListeners();
    });
  }

  //tabBar 切换方法
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
}
