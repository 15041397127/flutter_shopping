import 'package:flutter/material.dart';
import '../provide/counter.dart';
import 'package:provide/provide.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('购物车'),),
      body: Center(
        child: Column(
          children: <Widget>[
             Number(),
            MyButton()
          ],
        ),
      ),

    );
  }
}


class Number extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 200),
      child:Provide<Counter>(
          builder: (context,child,conunter){
            return Text(
              '${conunter.value}',
              style: Theme.of(context).textTheme.display1,
            );
          }
      ),
    );
  }
}

class MyButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: RaisedButton(
        onPressed: (){
          Provide.value<Counter>(context).increment();
        },
        child: Text('递增'),
      ),
    );
  }
}

