import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';


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
    _getCategory();
    return Container(
      child: Center(
        child: Text('分类页面'),
      ),
    );
  }
  
  
  void _getCategory()async{
    
    await request('getCategory').then((val){
      
      var data = json.decode(val.toString());
      
      CategoryListModel categoryListModel = CategoryListModel.fromJson(data['data']);
      categoryListModel.data.forEach((item)=>print(item.mallCategoryName));


//      print(data);
      
    });
    
  }
}