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

  //是否全选
  bool isAllCheck = true;

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
        'isCheck': true
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
      isAllCheck = true;
      tempList.forEach((item) {
        if (item['isCheck']) {
          allPrice += (item['count'] * item['price']);

          allGoodsCount += item['count'];
        } else {
          isAllCheck = false;
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

  deleteOneGoods(String goodsId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    cartString = preferences.get('cartInfo');

    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;

    int delIndex = 0;

    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }

      tempIndex++;
    });

    tempList.removeAt(delIndex);

    cartString = json.encode(tempList).toString();

    preferences.setString('cartInfo', cartString);

    await getCartInfo();
  }

  /**
   *  单选 全选逻辑
   */

  changCheckState(CartInfoMode cartInfoMode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    cartString = preferences.get('cartInfo');

    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tmpIndex = 0;

    int changeIndex = 0;

    tempList.forEach((item) {
      if (item['goodsId'] == cartInfoMode.goodsId) {
        changeIndex = tmpIndex;
      }
      tmpIndex++;
    });

    tempList[changeIndex] = cartInfoMode.toJson();

    cartString = json.encode(tempList).toString();

    preferences.setString('cartInfo', cartString);

    await getCartInfo();
  }

  /**
   *  点击全选按钮操作
   */
  changeAllCheckBtnState(bool isCheck) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    cartString = preferences.get('cartInfo');

    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    List<Map> newList = [];

    //dart循环里不允许改变旧值
    for (var item in tempList) {
      var newItem = item;

      newItem['isCheck'] = isCheck;

      newList.add(newItem);
    }

    cartString = json.encode(newList).toString();

    preferences.setString('cartInfo', cartString);

    await getCartInfo();
  }

  /**
   * 商品数量加减
   */
  addOrReduceAction(CartInfoMode cartItem, String todo) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();

    cartString = preferences.getString('cartInfo');

    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;

    int changeIndex = 0;

    tempList.forEach((item) {

      if(item['goodsId'] == cartItem.goodsId){

        changeIndex = tempIndex;
      }
        tempIndex++;

    });

    if(todo=='add'){

      cartItem.count++;

    }else if(cartItem.count>1){

      cartItem.count--;
    }

    tempList[changeIndex] = cartItem.toJson();

    cartString = json.encode(tempList).toString();

    preferences.setString('cartInfo', cartString);

    await getCartInfo();

  }
}
