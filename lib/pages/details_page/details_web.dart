import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/details_info.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var goodsDetails = Provide.value<DetailInfoProvide>(context).goodsInfor.data.goodInfo.goodsDetail;


    return Container(

       child: Html(
         useRichText: false,
           data: goodsDetails

       ),
    );
  }
}
