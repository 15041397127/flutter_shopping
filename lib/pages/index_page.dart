import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'cart_page.dart';
import 'category_page.dart';
import 'home_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() {
    return _IndexPageState();
  }
}

class _IndexPageState extends State<IndexPage> {

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类'),
    ),

    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车'),
    ),

    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心'),
    )

  ];

  final List tabBodies = [
    HomePage(),
    CateGoryPage(),
    CartPage(),
    MemberPage()
  ];

  int currentIndex = 0;

  var currentPage;

  @override
  void initState() {
    // TODO: implement initState
    currentPage = tabBodies[currentIndex];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //屏幕适配 根据iphone6
    ScreenUtil.instance = ScreenUtil(
        width: 750,
        height: 1334
    )..init(context);
    // TODO: implement build
    return Scaffold(

      backgroundColor: Color.fromRGBO(244,245,245,1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, //需要三个以上才可以看出效果
          currentIndex: currentIndex,
          items: bottomTabs,
          onTap: (index){
           setState(() {
             currentIndex = index;
             currentPage = tabBodies[index];
           });
          },
      ),
      body: currentPage,

    );
  }
}
