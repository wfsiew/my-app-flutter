import 'package:flutter/material.dart';
import 'input-field.dart';

class Checkout extends StatefulWidget {
  Checkout({Key key, this.title}) : super(key: key);

  static const String routeName = '/Checkout';

  final String title;

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  bool giftwrap = false;
  String name;
  String addr1;
  String addr2;
  String addr3;
  String city;
  String state;
  String zip;
  String country;

  final formKey = GlobalKey<FormState>();

  Widget buildContent() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            Text(
              'Ship to',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            InputField(
              label: 'Name',
              onChanged: (String s) {
                setState(() {
                 name = s;
                 print('============== $s');
                });
              },
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 5.0),
              child: Text(
                'Address',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            InputField(
              label: 'Line 1',
              onChanged: (String s) {
                setState(() {
                 addr1 = s; 
                });
              },
            ),
            InputField(
              label: 'Line 2',
              onChanged: (String s) {
                setState(() {
                 addr2 = s; 
                });
              },
            ),
            InputField(
              label: 'Line 3',
              onChanged: (String s) {
                setState(() {
                 addr3 = s; 
                });
              },
            ),
            InputField(
              label: 'City',
              onChanged: (String s) {
                setState(() {
                 city = s; 
                });
              },
            ),
            InputField(
              label: 'State',
              onChanged: (String s) {
                setState(() {
                 state = s; 
                });
              },
            ),
            InputField(
              label: 'Zip',
              onChanged: (String s) {
                setState(() {
                 zip = s; 
                });
              },
            ),
            InputField(
              label: 'Country',
              onChanged: (String s) {
                setState(() {
                 country = s; 
                });
              },
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 5.0),
              child: Text(
                'Options',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: giftwrap,
                  onChanged: (bool b) {
                    setState(() {
                     giftwrap = b; 
                    });
                  },
                ),
                Text('Gift wrap these items'),
              ],
            ),
            Center(
              child: RaisedButton(
                color: Colors.red,
                elevation: 5,
                child: Text(
                  'Complete Order',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                onPressed: () {

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: buildContent(),
    );
  }
}