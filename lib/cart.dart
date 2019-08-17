import 'package:flutter/material.dart';
import 'dart:async';
import 'cart-service.dart';
import 'models.dart';
import 'helpers.dart';
import 'bottom-bar.dart';
import 'quantity-input.dart';
import 'checkout.dart';

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

    setState(() {
     lines = ls;
     summary = cart;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void updateQuantity(int productID, int quantity) async {
    await updateItem(productID, quantity);
    print('product $productID - qty = $quantity');
    await getData();
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
                  color: Colors.red,
                  elevation: 5,
                  child: Text(
                    'Check Out',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Checkout.routeName);
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
                  icon: Icon(Icons.delete, size: 24.0, color: Colors.red),
                  onPressed: () async {
                    await removeItem(lines[index].product);
                    await getData();
                  },
                ),
                trailing: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 140,
                    height: 20,
                    child: QuantityInput(
                      value: '${lines[index].quantity}',
                      productID: lines[index].product.productID,
                      onQuantityChanged: updateQuantity,
                    ),
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