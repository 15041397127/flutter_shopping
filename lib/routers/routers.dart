import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';


class Routers{

  //根目录
  static String root = '/';

  static String detailsPage = '/detail';

  static void configureRoutes(Router router){

    //默认页面 找不到页面的情况
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> parms){

        print('ERROR ===> ROUTE WAS NOT FOUND');
      }
    );

    //配置路由 配置detailsPage的路由
    router.define(detailsPage, handler: detailsHandler);

    //其他的路由 可以继续写上一个


  }

}