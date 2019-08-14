import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/cart-service.dart';
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

  Future getData() async {
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
      body: Column(
        children: <Widget>[
          summary == null ? Text('Cart is empty') : Text('carts ${summary.totalPrice} ${summary.totalQuantity}'),
          RaisedButton(
            child: Text('Clear'),
            onPressed: () {
              clear();
              this.getData();
            },
          ),
        ],
      ),
    );
  }
}