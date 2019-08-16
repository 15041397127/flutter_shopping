import 'package:flutter/material.dart';
import '../provide/counter.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provide/cart.dart';
import 'cart_page/cart_item.dart';
import 'cart_page/cart_bottom.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
          future: _getCartInfo(context),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              List cartList =
                  Provide.value<CartProvide>(context).cartInfoModelList;

              return Stack(
                children: <Widget>[
                  ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      return CartItem(cartList[index]);
                    },
                  ),
                  Positioned(bottom: 0.0,left: 0.0, child: CartBottom()),
                ],
              );
            } else {
              return Text('正在加载');
            }
          }),
    );
  }

  //获取 数据方法
  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();

    return 'end';
  }
}

/**
 *class CartPage extends StatefulWidget {
    @override
    _CartPageState createState() {
    return _CartPageState();
    }
    }

    class _CartPageState extends State<CartPage> {
    List<String> testList = [];

    //增加方法
    void _addMethod() async {
    //初始化
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String temp = '啥玩意儿啊????';

    testList.add(temp);

    preferences.setStringList('test', testList);

    _show();
    }

    //查询
    void _show() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getStringList('test') != null) {
    setState(() {
    testList = preferences.getStringList('test');
    });
    }
    }

    //删除
    void _clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.remove('test');

    setState(() {
    testList = [];
    });
    //    preferences.clear();//所有
    }

    @override
    void initState() {
    _show();
    super.initState();
    }

    @override
    void dispose() {
    super.dispose();
    }

    @override
    Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
    appBar: AppBar(
    title: Text('购物车'),
    ),
    body: Center(
    child: Column(
    children: <Widget>[
    Container(
    height: 500.0,
    child: ListView.builder(
    itemCount: testList.length,
    itemBuilder: (BuildContext context, int index) {
    return ListTile(
    title: Text(testList[index]),
    );
    },
    ),
    ),
    RaisedButton(
    onPressed: (){
    _addMethod();
    },
    child: Text('增加'),
    ),
    RaisedButton(
    onPressed: (){
    _clear();
    },
    child: Text('清空'),
    ),
    ],
    ),
    ),
    );
    }
    }
 */

/**
 * class CartPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
    appBar: AppBar(title: Text('购物车'),),
    body: Center(
    child: Column(
    children: <Widget>[
    Number(),
    MyButton()
    ],
    ),
    ),

    );
    }
    }


    class Number extends StatelessWidget {


    @override
    Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
    margin: EdgeInsets.only(top: 200),
    child:Provide<Counter>(
    builder: (context,child,conunter){
    return Text(
    '${conunter.value}',
    style: Theme.of(context).textTheme.display1,
    );
    }
    ),
    );
    }
    }

    class MyButton extends StatelessWidget {


    @override
    Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
    child: RaisedButton(
    onPressed: (){
    Provide.value<Counter>(context).increment();
    },
    child: Text('递增'),
    ),
    );
    }
    }

 */
