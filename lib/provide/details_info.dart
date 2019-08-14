import 'package:flutter/material.dart';
import '../model/details_model.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailInfoProvide with ChangeNotifier {
  DetailsModel goodsInfor = DetailsModel();

  //从后台获取数据

  getGoodsInfor(String id) {
    var formData = {'goodId': id};

    request('getGoodDetailById', formData: formData).then((val) {
      var responsData = json.decode(val.toString());

      print(responsData);

      goodsInfor = DetailsModel.fromJson(responsData);
      notifyListeners();
    });
  }
}
