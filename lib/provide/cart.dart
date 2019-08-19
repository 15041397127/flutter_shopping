import 'package:shared_preferences/shared_preferences.dart';
import '../model/cart_info.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";

  List<CartInfoMode> cartInfoModelList = [];

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    cartString = preferences.getString('cartInfo');

    //decode转成list
    var temp = cartString == null ? [] : json.decode(cartString.toString());

    //强转成list
    List<Map> tempList = (temp as List).cast();

    bool isHave = false;

    int ival = 0;

    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartInfoModelList[ival].count++;
        isHave = true;
      }
      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck':true
      };

      tempList.add(newGoods);
      cartInfoModelList.add(CartInfoMode.fromJson(newGoods));
    }

    cartString = json.encode(tempList).toString();

    print('cartString:${cartString}');

    print('cartInfoModelList:${cartInfoModelList}');

    preferences.setString('cartInfo', cartString);

    notifyListeners();
  }

  remove() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.remove('cartInfo');

    print('清空完成------------------------');

    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    cartString = preferences.getString('cartInfo');

    cartInfoModelList = [];
    if (cartString != null) {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();


      tempList.forEach((item) {
        cartInfoModelList.add(CartInfoMode.fromJson(item));
      });
    } else {
      cartInfoModelList = [];
    }

    notifyListeners();
  }
}
