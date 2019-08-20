import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';


class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Provide<CartProvide>(builder: (context, child, cartItem) {
        return Row(
          children: <Widget>[
            _selectAllBtn(context),
            _allPriceArea(context),
            _goButton(context)
          ],
        );
      }),
    );
  }

  Widget _selectAllBtn(context) {

    bool isAllCheck = Provide.value<CartProvide>(context).isAllCheck;

    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            onChanged: (bool val) {
              Provide.value<CartProvide>(context).changeAllCheckBtnState(val);
            },
            activeColor: Colors.pink,
          ),
          Text('全选'),
        ],
      ),
    );
  }

  Widget _allPriceArea(context) {
    double allPrice = Provide.value<CartProvide>(context).allPrice;

    return Container(
      width: ScreenUtil().setWidth(430),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '合计:',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36.0),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(150),
                child: Text(
                  '${allPrice}',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: ScreenUtil().setSp(36.0),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(400),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费,预购免配送费',
              style: TextStyle(
                color: Colors.black38,
                fontSize: ScreenUtil().setSp(22.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _goButton(context) {
    int allGoodsCount = Provide.value<CartProvide>(context).allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(180),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Container(
        margin: EdgeInsets.only(right: 5.0),
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: InkWell(
          onTap: () {},
          child: Text(
            '${allGoodsCount}',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
