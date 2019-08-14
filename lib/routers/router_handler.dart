import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../pages/details_page.dart';


//路由handler配置
// 单个路由配置
Handler detailsHandler = Handler(

  //固定写法
  handlerFunc: (BuildContext context,Map<String,List<String>> params ){

    String goodsId = params['id'].first;

    print('index>details goodsId is$goodsId}');

    return DetailPage(goodsId);

  }

);
