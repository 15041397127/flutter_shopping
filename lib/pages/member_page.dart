import 'package:flutter/material.dart';
import '../provide/counter.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('会员中心'),
        ),
        body: ListView(
          children: <Widget>[
            _topHeader(),
            _orderTitle(),
            _orderType()
          ],
        ));
  }

  /**
   * 头部
   */
  Widget _topHeader() {
    return Container(
      width: ScreenUtil().setWidth(750),
//      height: ScreenUtil().setHeight(220),
      padding: EdgeInsets.all(20.0),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30.0),
            child: ClipOval(
              child: Image.network(
                  'http://wx4.sinaimg.cn/large/6901e2b9ly1g6631k8a0uj20ko0bmgmy.jpg',width: 100,height: 100,fit: BoxFit.fill,),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              '啥玩意儿啊',
              style: TextStyle(
                  color: Colors.black54, fontSize: ScreenUtil().setSp(36.0)),
            ),
          ),
        ],
      ),
    );
  }


   //我的订单标题
   Widget _orderTitle(){

    return Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0,color: Colors.black12)
        ),
      ),
      child:ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ) ,
    );
   }

   Widget _orderType(){

      return Container(
        margin: EdgeInsets.only(top: 5.0),
        width: ScreenUtil().setWidth(750.0),
        height: ScreenUtil().setHeight(150.0),
        padding: EdgeInsets.only(top: 20.0),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(187.0),
              child: Column(
                children: <Widget>[
                  Icon(Icons.party_mode,size: 30.0,),
                  Text('待付款'),
                ],
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(187.0),
              child: Column(
                children: <Widget>[
                  Icon(Icons.query_builder,size: 30.0,),
                  Text('待发货'),
                ],
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(187.0),
              child: Column(
                children: <Widget>[
                  Icon(Icons.directions_car,size: 30.0,),
                  Text('待收货'),
                ],
              ),
            ),

            Container(
              width: ScreenUtil().setWidth(187.0),
              child: Column(
                children: <Widget>[
                  Icon(Icons.content_paste,size: 30.0,),
                  Text('待评价'),
                ],
              ),
            ),
          ],
        ),
      );
   }

}

/*
class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('会员中心'),),
      body: Center(
        child: Provide<Counter>(
          builder: (context,child,counter){

            return Text(
              '${counter.value}',
              style: Theme.of(context).textTheme.display1,
            );
          },
        ),
      ),
    );
  }
}
*/
