import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_info.dart';
import 'details_page/details_top_area.dart';
import 'details_page/details_explain.dart';
import 'details_page/details_tabbar.dart';
import 'details_page/details_web.dart';
import 'details_page/details_bottom.dart';

class DetailPage extends StatelessWidget {
  final String goodsId;

  DetailPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情'),
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                  child: ListView(
                    children: <Widget>[
                      DetailTopArea(),
                      DetailsExplain(),
                      DetailTabBar(),
                      DetailsWeb()
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                   left: 0.0,
                    child: DetailBottom(),
                ),
              ],
            );
          } else {
            return Text(
              '加载中....',
            );
          }
        },
      ),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailInfoProvide>(context).getGoodsInfor(goodsId);
    return '完成加载';
  }
}

/**
 * class DetailPage extends StatefulWidget {

    final String goodsId;
    DetailPage(this.goodsId);

    @override
    _DetailPageState createState() {
    return _DetailPageState();
    }
    }

    class _DetailPageState extends State<DetailPage> {

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
    _getBackInfo(context);
    // TODO: implement build
    return Scaffold(
    appBar: AppBar(title: Text('详情页面'),),
    body: Center(child: Text('详情页面商品详情${widget.goodsId}'),),
    );
    }


    void _getBackInfo(BuildContext context)async{

    await Provide.value<DetailInfoProvide>(context).getGoodsInfor(widget.goodsId);
    print('加载完成');
    }


    }
 */
