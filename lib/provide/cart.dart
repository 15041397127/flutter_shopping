import 'package:shared_preferences/shared_preferences.dart';
import '../model/cart_info.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";

  List<CartInfoMode> cartInfoModelList = [];

  //总价格
  double allPrice = 0;

  //商品总数量
  int allGoodsCount = 0;

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
      allPrice = 0;
      allGoodsCount = 0;
      tempList.forEach((item) {

        if(item['isCheck']){

              allPrice += (item['count'] * item['price']);

              allGoodsCount += item['count'];
        }

        cartInfoModelList.add(CartInfoMode.fromJson(item));
      });
    } else {
      cartInfoModelList = [];
    }

    notifyListeners();
  }

/**
 * 删除单个购物车商品
 */

   deleteOneGoods(String goodsId) async{

    SharedPreferences preferences  = await SharedPreferences.getInstance();
    
    cartString = preferences.get('cartInfo');
    
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;

    int delIndex = 0;

    tempList.forEach((item){

      if(item['goodsId'] == goodsId){

        delIndex = tempIndex;

      }

      tempIndex++;
    });

     tempList.removeAt(delIndex);

     cartString = json.encode(tempList).toString();

     preferences.setString('cartInfo', cartString);

     await getCartInfo();

   }
}
