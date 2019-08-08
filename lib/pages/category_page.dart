import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      appBar: AppBar(title: Text('商品分类'),),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
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

  @override
  void initState() {
    _getCategory();
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
        border: Border(right: BorderSide(width: 1,color: Colors.black12))
      ),
      child:ListView.builder(
        itemCount: list.length,
          itemBuilder: (BuildContext context,int index){
            return _leftInkWell(index);
          }
      ),
    );
  }

  Widget _leftInkWell(int index){

    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10,top: 20),
        decoration:BoxDecoration(color: Colors.white,border: Border(bottom: BorderSide(width: 1,color: Colors.black12))),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(26)),
        ),
      ),
    );
  }


  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());


      CategoryModel categoryModel = CategoryModel.fromJson(data);
      setState(() {

       list = categoryModel.data;
      });
//      categoryModel.data.forEach((item) => print(item.mallCategoryName));

    });
  }
}
