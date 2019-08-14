import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  CartLine line;

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String carts = pref.getString('carts');
    var x = jsonDecode(carts);
    print(carts);
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
          child: Text('carts'),
        ),
      ),
    );
  }
}