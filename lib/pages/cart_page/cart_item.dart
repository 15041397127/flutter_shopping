import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cart_info.dart';
import 'car_count.dart';

class CartItem extends StatelessWidget {
  final CartInfoMode cartInfoMode;

  CartItem(this.cartInfoMode);

  @override
  Widget build(BuildContext context) {
    print(cartInfoMode);
    // TODO: implement build
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1.0, color: Colors.black12)),
      ),
      child: Row(
        children: <Widget>[
          _cartCheckBt(context,cartInfoMode),
          _cartImage(),
          _cartGoodsName(),
          _cartPrice()
        ],
      ),
    );
  }

  //多选按钮
  Widget _cartCheckBt(context,item) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool) {},
      ),
    );
  }

  //商品图片
  Widget _cartImage() {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration:
          BoxDecoration(border: Border.all(width: 1.0, color: Colors.black12)),
      child: Image.network(cartInfoMode.images),
    );
  }

  //商品名称
  Widget _cartGoodsName() {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(cartInfoMode.goodsName),
          CartCount()
        ],
      ),
    );
  }

  //商品价格
  Widget _cartPrice() {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('¥${cartInfoMode.price}'),
          Container(
              child: InkWell(
            onTap: () {},
            child: Icon(
              Icons.delete,
              color: Colors.black26,
              size: 30.0,
            ),
          )),
        ],
      ),
    );
  }
}
