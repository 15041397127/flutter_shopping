import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  String homePageContent = '正在获取数据';

//  @override
//  void initState() {
//
//    getHomePageContent().then((val){
//
//    setState(() {
//      homePageContent = val.toString();
//    });
//    });
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      
      appBar: AppBar(
        title: Text('首页'),
        elevation: 0.0,
      ),
      
      //SingleChildScrollView与listView冲突
      //使用FutureBuilder 数据驱动视图
      body: FutureBuilder(
         future: getHomePageContent(),
          builder: (context,snapshot){
                if(snapshot.hasData){
                  var data = json.decode(snapshot.data.toString());
                  List<Map> swiper = (data['data']['slides']as List).cast();
                  return Column(
                    children: <Widget>[
                      SwiperDiy(swiperDateList: swiper,),
                    ],

                  );
                }else{
                  return Center(
                    child: Text(
                      '加载中....'
//                  style: TextStyle(
//                    fontSize:ScreenUtil().setSp(28,false),
                  ),
                  );
                }
          },
      ),
    );
  }
}


//首页轮播组件
class SwiperDiy extends StatelessWidget {

   final List swiperDateList;
//  SwiperDiy({Key key,this.swiperDateList}):super(key:key);
  SwiperDiy({this.swiperDateList});//目前可以省略这么写 构造函数

//   List arr = List();
  @override
  Widget build(BuildContext context) {

    //屏幕适配 根据iphone6
    ScreenUtil.instance = ScreenUtil(
      width: 750,
      height: 1334
    )..init(context);

    print('设备像素密度:${ScreenUtil.pixelRatio}');
    print('设备高:${ScreenUtil.screenHeight}');
    print('设备宽:${ScreenUtil.screenWidth}');
//push


//     arr = ['http://wx4.sinaimg.cn/large/7695e2e2ly1g5pnrmegv6j20m80f5taf.jpg',
//           'http://wx4.sinaimg.cn/large/7695e2e2ly1g5pnrm4b9vj212z0lltdf.jpg',
//           'http://wx3.sinaimg.cn/large/006FCqYVgy1g5pu3o5phzj31910u07ab.jpg'
//     ];
    // TODO: implement build
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(

        itemCount:swiperDateList.length,
        itemBuilder: (BuildContext context,int index){
            return Image.network('${swiperDateList[index]['image']}',fit: BoxFit.fill,);
        },
        pagination: SwiperPagination(),
        autoplay: true,

      ),

    );
  }
}







//测试方法
/*
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String showText = '无数据';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('模拟极客时间请求'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: _jike,
                child: Text('请求数据'),
              ),
              Text(showText),
            ],
          ),
        ),
      ),
    );
  }

  void _jike(){

    print('开始请求数据./.......');
    getHttp().then((val){

      setState(() {
        showText = val['data'].toString();
      });
    });


  }

  Future getHttp() async {
    try {
      Response response;
      Dio dio = Dio();
      //模拟请求头
      dio.options.headers = httpHeaders;
      response =
          await dio.get('https://time.geekbang.org/serv/v1/column/newAll');

      print(response);

      return response.data;
    } catch (e) {
      return print(e);
    }
  }

//  https://time.geekbang.org/serv/v1/column/newAll
}

*/

/*
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
//      getHttp(typeController.text.toString()).then((val) {
//        setState(() {
//          showText = val['data']['name'].toString();
//        });
//      });

      postHttp(typeController.text.toString()).then((val) {
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


  Future postHttp(String TypeTest) async {
    
    print('hahaha');
    try {
      Response response;
      var data = {'name': TypeTest};

      response = await Dio().post(
          'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/post_dabaojian',
          queryParameters: data);

      return response.data;
    } catch (e) {
      print(e);
    }
  }


  
}

*/

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
