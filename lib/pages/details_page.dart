import 'package:flutter/material.dart';

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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('详情页面'),),
      body: Center(child: Text('详情页面商品详情${widget.goodsId}'),),
    );
  }
}