import 'package:shared_preferences/shared_preferences.dart';
import '../model/details_model.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class CartProvide with ChangeNotifier{

  String cartString = "[]";

  save(goodsId,goodsName,count,price,images)async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    cartString = preferences.getString('cartInfo');

    //decode转成list
    var temp = cartString == null ?[]:json.decode(cartString.toString());

    //强转成list
    List<Map>tempList = (temp as List).cast();
    
    bool isHave = false;
    
    int ival = 0;
    
    tempList.forEach((item){

      if (item['goodsId'] == goodsId){

        tempList[ival]['count'] = item['count'] + 1;

        isHave = true;

      }
       ival++;
    });

    if(!isHave){
      tempList.add({

        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
        'images':images
      });
    }
    
    cartString = json.encode(tempList).toString();

    print('cartString:${cartString}');

    preferences.setString('cartInfo', cartString);

    notifyListeners();

  }


  remove()async{

     SharedPreferences preferences = await SharedPreferences.getInstance();

     preferences.remove('cartInfo');

     print('清空完成------------------------');

     notifyListeners();

  }


}