import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

//获取首页主题内容

Future getHomePageContent() async {
  try {
    print('开始获取首页数据........');

    Response response;
    Dio dio = Dio();
    dio.options.contentType = ContentType.parse(
        'application/x-www-form-urlencoded'); //用表单形式创建contentType

    //经纬度
    var formData = {'lon': '115.02932', 'lat': '35.76189'};

    //post请求 data参数
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常.');
    }
  } catch (e) {
    return print('ERROR:==========>${e}');
  }
}
