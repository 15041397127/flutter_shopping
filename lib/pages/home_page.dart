import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    gethttp();
    // TODO: implement build
    return Center(
      child: Text('首页'),
    );
  }


  void gethttp() async {
    try {
      Response response;

      response = await Dio().get('https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=子望');

      return  print(response);

    } catch (e) {
      return debugPrint(e);
    }
  }

}
