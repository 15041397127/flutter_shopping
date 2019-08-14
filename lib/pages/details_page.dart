import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_info.dart';

class DetailPage extends StatefulWidget {

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