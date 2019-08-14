import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/cart-service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'models.dart';

class Cart extends StatefulWidget {
  Cart({Key key, this.title}) : super(key: key);

  static const String routeName = '/Cart';

  final String title;

  @override
  _CartState createState() =>_CartState();
}

class _CartState extends State<Cart> {

  List<CartLine> lines;
  CartSummary summary;

  void getData() async {
    var ls = await getLines();
    var cart = CartSummary.getSummary(ls);

    this.setState(() {
      lines = ls;
      summary = cart;
    });
  }

  @override
  void initState(){
    this.getData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Text('carts ${summary.totalPrice} ${summary.totalQuantity}'),
        ),
      ),
    );
  }
}