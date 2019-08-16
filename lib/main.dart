import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'package:provide/provide.dart';
import 'provide/counter.dart';
import 'provide/child_category.dart';
import 'provide/category_goods_list.dart';
import 'package:fluro/fluro.dart';
import 'routers/application.dart';
import 'routers/routers.dart';
import 'provide/details_info.dart';
import 'provide/cart.dart';

void main(){

  var counter = Counter();
  var childCategory = ChildCategory();
  var goodsDetailList = CategoryGoodListProvide();
  var detailInfoProvide = DetailInfoProvide();
  var cartProvide = CartProvide();
  var proivders = Providers();
  proivders
           ..provide(Provider<Counter>.value(counter))
           ..provide(Provider<ChildCategory>.value(childCategory))//注册依赖 绑定各个类可多个
           ..provide(Provider<CategoryGoodListProvide>.value(goodsDetailList))//商品详情绑定
           ..provide(Provider<DetailInfoProvide>.value(detailInfoProvide))//商品详情
           ..provide(Provider<CartProvide>.value(cartProvide));//购物车

  runApp(ProviderNode(child:MyApp(),providers:proivders));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    //注入
    Routers.configureRoutes(router);
    Application.router = router;

    // TODO: implement build
    return Container(
      child:MaterialApp(
        onGenerateRoute: Application.router.generator,
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


