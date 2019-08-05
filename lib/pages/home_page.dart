import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();
  String showText = '欢迎您';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('首页测试Dio'),
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    labelText: '美女类型',
                    helperText: '请输入你喜欢的类型'),
                autofocus: false, //关闭第一响应者  键盘不默认打开
              ),
              RaisedButton(
                child: Text('选择完毕'),
                onPressed: _choiceAction,
              ),
              Text(
                showText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        )),
      ),
    );
  }

  void _choiceAction() {
    print('开始选择');

    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text('类型不能为空')));
    } else {
      getHttp(typeController.text.toString()).then((val) {
        setState(() {
          showText = val['data']['name'].toString();
        });
      });
    }
  }

  Future getHttp(String TypeTest) async {
    try {
      Response response;
      var data = {'name': TypeTest};

      response = await Dio().get(
          'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian',
          queryParameters: data);

      return response.data;
    } catch (e) {
      print(e);
    }
  }
}

//class HomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    gethttp();
//    // TODO: implement build
//    return Center(
//      child: Text('首页'),
//    );
//  }
//
//
//  void gethttp() async {
//    try {
//      Response response;
//
//      response = await Dio().get('https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=子望');
//
//      return  print(response);
//
//    } catch (e) {
//      return debugPrint(e);
//    }
//  }
//
//}
