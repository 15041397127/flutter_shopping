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
