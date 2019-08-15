import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(84),
//      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(150),
              alignment: Alignment.center,
              child: Icon(
                Icons.shopping_cart,
                size: 35,
                color: Colors.red,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
                width: ScreenUtil().setWidth(300),
                height: ScreenUtil().setHeight(84),
                alignment: Alignment.center,
                color: Colors.green,
                child: Text(
                  '加入购物车',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(28.0),
                  ),
                )),
          ),
          InkWell(
            onTap: () {},
            child: Container(
                width: ScreenUtil().setWidth(300),
                height: ScreenUtil().setHeight(84),
                alignment: Alignment.center,
                color: Colors.red,
                child: Text(
                  '立即购买',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(28.0),
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}
