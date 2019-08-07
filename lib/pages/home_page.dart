import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navgatorList = (data['data']['category'] as List).cast();
            String adPicture =
                data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            List<Map>recommendList = (data['data']['recommend']as List).cast();

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SwiperDiy(
                    swiperDateList: swiper,
                  ),
                  TopNavigator(
                    navigatorList: navgatorList,
                  ),
                  AdBanner(adPicture: adPicture),
                  CallPhone(
                    leaderImage: leaderImage,
                    leaderPhone: leaderPhone,
                  ),
                  Recommend(recommendList: recommendList,),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('加载中....'
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

/***
 *首页轮播组件
 *
 */
class SwiperDiy extends StatelessWidget {
  final List swiperDateList;

//  SwiperDiy({Key key,this.swiperDateList}):super(key:key);
  SwiperDiy({this.swiperDateList}); //目前可以省略这么写 构造函数

//   List arr = List();
  @override
  Widget build(BuildContext context) {
    print('设备像素密度:${ScreenUtil.pixelRatio}');
    print('设备高:${ScreenUtil.screenHeight}');
    print('设备宽:${ScreenUtil.screenWidth}');

//     arr = ['http://wx4.sinaimg.cn/large/7695e2e2ly1g5pnrmegv6j20m80f5taf.jpg',
//           'http://wx4.sinaimg.cn/large/7695e2e2ly1g5pnrm4b9vj212z0lltdf.jpg',
//           'http://wx3.sinaimg.cn/large/006FCqYVgy1g5pu3o5phzj31910u07ab.jpg'
//     ];
    // TODO: implement build
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: swiperDateList.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            '${swiperDateList[index]['image']}',
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

/**
 * 顶部导航组件
 */
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({this.navigatorList});

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }

    // TODO: implement build
    return Container(
      height: ScreenUtil().setHeight(250),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 1.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

/**
 * 广告区域
 */
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({this.adPicture});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Image.network(adPicture),
    );
  }
}

/**
 * 拨打电话功能
 */
class CallPhone extends StatelessWidget {
  //店长图片
  final String leaderImage;

  //店长电话
  final String leaderPhone;

  CallPhone({this.leaderImage, this.leaderPhone});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:' + leaderPhone;
//    String url = 'https://flutterchina.club/';
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url不能访问异常';
    }
  }
}

/**
 * 商品推荐
 */
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({this.recommendList});

  //标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12)),
      ),
      child: Text(
        '商品详情',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  //商品单独项目
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(280),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(width: 0.5, color: Colors.black12)),
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('¥${recommendList[index]['mallPrice']}'),
            Text(
              '¥${recommendList[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  //横向列表
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(280),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (BuildContext context, int index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

//    for(int i =0;i<5;i++){
//
//      this.recommendList.add(this.recommendList[0]);
//    }

//    this.recommendList.add(this.recommendList);
    // TODO: implement build
    return Container(
      height: ScreenUtil().setHeight(330),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList()
        ],
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
