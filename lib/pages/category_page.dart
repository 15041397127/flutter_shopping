import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';
import '../model/category_goods_list_model.dart';
import '../provide/category_goods_list.dart';

class CateGoryPage extends StatefulWidget {
  @override
  _CateGoryPageState createState() {
    return _CateGoryPageState();
  }
}

class _CateGoryPageState extends State<CateGoryPage> {
  @override
  void initState() {
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
        title: Text('商品分类'),
        elevation: 0.0,
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//左侧分类导航栏
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() {
    return _LeftCategoryNavState();
  }
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0;

  @override
  void initState() {
    _getCategory();
    _getGoodsList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return _leftInkWell(index);
          }),
    );
  }

  Widget _leftInkWell(int index) {
    //更改按下的颜色
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;

    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });

        //点击改变右侧内容 使用provide
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        //改变状态
        Provide.value<ChildCategory>(context)
            .getChildCategory(childList, categoryId);
        _getGoodsList(categoryId: categoryId); //{}可选参数需要带Key:key值
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(26)),
        ),
      ),
    );
  }

  //获取分类接口数据
  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());

      CategoryModel categoryModel = CategoryModel.fromJson(data);
      setState(() {
        list = categoryModel.data;
      });
//      categoryModel.data.forEach((item) => print(item.mallCategoryName));

      //初始化右边导航栏 第一个数组的数据
      Provide.value<ChildCategory>(context)
          .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

  //获取详情接口数据
  void _getGoodsList({String categoryId}) async {
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': '',
      'page': 1
    };

    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());

      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodListProvide>(context)
          .getGoodsList(goodsList.data);

//      setState(() {
//        list = goodsList.data;
//      });

      // print('分类商品列表>>>>>>>.${data}');

      // print('>>>>>>>>>${goodsList.data[0].goodsName}');
    });
  }
}

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() {
    return _RightCategoryNavState();
  }
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    List list = [
//      '名酒',
//      '宝丰',
//      '北京二锅头',
//      '名酒',
//      '宝丰',
//      '北京二锅头',
//      '名酒',
//      '宝丰',
//      '北京二锅头',
//      '名酒',
//      '宝丰',
//      '北京二锅头'
//    ];

    // TODO: implement build
    return Provide<ChildCategory>(
      builder: (context, chilid, childCategory) {
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570), //750-180
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black12))),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return _rightInkWell(
                    childCategory.childCategoryList[index], index);
              }),
        );
      },
    );
  }

  Widget _rightInkWell(BxMallSubDto item, int index) {
    bool isClick = false;

    isClick = (index == Provide.value<ChildCategory>(context).chilidIndex)
        ? true
        : false;

    return InkWell(
      onTap: () {
        Provide.value<ChildCategory>(context).changeChildIndex(index);
        _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClick ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }

  //获取详情接口数据
  void _getGoodsList(String categorySubId) async {
    var categoryId = Provide.value<ChildCategory>(context).categoryId;

    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': categorySubId == '00' ? '':categorySubId,
      'page': 1
    };

    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());

      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Provide.value<CategoryGoodListProvide>(context).getGoodsList([]);
      } else {
        Provide.value<CategoryGoodListProvide>(context)
            .getGoodsList(goodsList.data);
      }
    });
  }
}

/**
 *  商品列表详情页面 可上拉加载
 */

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() {
    return _CategoryGoodsListState();
  }
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
//  List list = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Provide<CategoryGoodListProvide>(
      builder: (context, child, data) {
        if (data.goodsList.length > 0) {
          return Expanded(
            //Flexible
            child: Container(
              width: ScreenUtil().setWidth(570),
//              height: ScreenUtil().setHeight(970),
              child: ListView.builder(
                  itemCount: data.goodsList.length,
                  itemBuilder: (context, index) {
                    return _listWidget(data.goodsList, index);
                  }),
            ),
          );
        } else {
          return Center(
            child: Text('暂时没有数据'),
          );
        }
      },
    );
  }

  Widget _goodsImage(list, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[index].image),
    );
  }

  Widget _goodsName(list, index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(350),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(list, index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil().setWidth(350),
      child: Row(
        children: <Widget>[
          Text(
            '价格:¥${list[index].presentPrice}',
            style:
                TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '¥${list[index].oriPrice}',
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough),
          ),
          //带有删除线的风格
        ],
      ),
    );
  }

  Widget _listWidget(List list, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
        child: Row(
          children: <Widget>[
            _goodsImage(list, index),
            Column(
              children: <Widget>[
                _goodsName(list, index),
                _goodsPrice(list, index),
              ],
            )
          ],
        ),
      ),
    );
  }
}
