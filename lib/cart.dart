import 'package:flutter/material.dart';
import 'dart:async';
import 'cart-service.dart';
import 'models.dart';
import 'helpers.dart';
import 'bottom-bar.dart';
import 'quantity-input.dart';

class Cart extends StatefulWidget {
  Cart({Key key, this.title}) : super(key: key);

  static const String routeName = '/Cart';

  final String title;

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  List<CartLine> lines;
  CartSummary summary;
  int currIndex = 1;

  Future<void> getData() async {
    var ls = await getLines();
    var cart = CartSummary.getSummary(ls);

    this.setState(() {
      lines = ls;
      summary = cart;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Widget buildList() {
    if (lines.length < 1) {
      return Container(
        padding: const EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 8.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'There are no items in this cart',
                  style: TextStyle(
                    fontSize: 18.0
                  ),
                ),
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('CONTINUE SHOPPING'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ),
          ],
        ),
      );
    }

    return Container(
      child: ListView.builder(
        itemCount: lines.length + 2,
        padding: const EdgeInsets.all(2.0),
        itemBuilder: (context, index) {
          if (index == lines.length && lines.length > 0) {
            return Card(
              child: ListTile(
                title: Text(
                  'Total:',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 18.0
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Text(
                      '${formatAmt(summary.totalPrice)}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    )
                  ),
                ),
              ),
            );
          }

          else if (index == lines.length + 1 && lines.length > 0) {
            return Container(
              child: Center(
                child: RaisedButton(
                  color: Colors.redAccent,
                  child: Text(
                    'Check Out',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  onPressed: () {

                  },
                ),
              ),
            );
          }

          else {
            return Card(
              child: ListTile(
                title: Text(
                  '${lines[index].product.name}',
                  style: TextStyle(
                    fontSize: 18.0
                  ),
                ),
                subtitle: Text(
                  '${formatAmt(lines[index].product.price)}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                leading: IconButton(
                  icon: Icon(Icons.delete, size: 24.0, color: Colors.redAccent),
                  onPressed: () async {
                    removeItem(lines[index].product);
                    setState(() {
                      lines.removeAt(index);
                      var cart = CartSummary.getSummary(lines);
                      summary = cart;
                    });
                  },
                ),
                trailing: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: QuantityInput(value: '${lines[index].quantity}'),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false,
      ),
      body: lines != null ? buildList() : Center(child: CircularProgressIndicator()),
      bottomNavigationBar: CustomBottomBar(index: 1),
    );
  }
}