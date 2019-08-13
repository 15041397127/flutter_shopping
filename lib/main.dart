import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'package:provide/provide.dart';
import 'provide/counter.dart';
import 'provide/child_category.dart';
import 'provide/category_goods_list.dart';

void main(){

  var counter = Counter();
  var childCategory = ChildCategory();
  var goodsDetailList = CategoryGoodListProvide();
  var proivders = Providers();
  proivders
           ..provide(Provider<Counter>.value(counter))
           ..provide(Provider<ChildCategory>.value(childCategory))//注册依赖 绑定各个类可多个
           ..provide(Provider<CategoryGoodListProvide>.value(goodsDetailList));//商品详情绑定


  runApp(ProviderNode(child:MyApp(),providers:proivders));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child:MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
       home: IndexPage(),
      ) ,

    );
  }
}


