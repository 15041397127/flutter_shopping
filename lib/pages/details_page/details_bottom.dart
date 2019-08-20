import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';
import '../../provide/details_info.dart';
import '../../provide/currentIndex.dart';

class DetailBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo =
        Provide.value<DetailInfoProvide>(context).goodsInfor.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var images = goodsInfo.image1;

    // TODO: implement build
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(84),
//      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  //跳转到购物车
                  Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                  Navigator.pop(context);
                },
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
              Provide<CartProvide>(builder:(context, child, val) {
                int goodsCount = Provide.value<CartProvide>(context).allGoodsCount;
                return Positioned(
                  top: 0.0,right: 10.0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        border: Border.all(
                           width: 2.0,
                           color: Colors.white,
                           
                        ),
                      borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        '${goodsCount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(22),
                        ),
                      ),
                    ),
                );
              }),
            ],
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context)
                  .save(goodsId, goodsName, count, price, images);
            },
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
            onTap: () async {
              await Provide.value<CartProvide>(context).remove();
            },
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
