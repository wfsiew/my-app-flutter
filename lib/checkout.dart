import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  Checkout({Key key, this.title}) : super(key: key);

  static const String routeName = '/Checkout';

  final String title;

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  bool giftwrap = false;

  Widget buildContent() {
    return Container(
      padding: const EdgeInsets.all(10.0),
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
          Row(
            children: <Widget>[
              SizedBox(
                width: 50,
                child: Text('Name'),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Name'
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
            child: Text(
              'Address',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 50,
                child: Text('Line 1'),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Line 1'
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 50,
                child: Text('Line 2'),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Line 2'
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 50,
                child: Text('Line 3'),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Line 3'
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 50,
                child: Text('City'),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'City',
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 50,
                child: Text('State'),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'State'
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 50,
                child: Text('Zip'),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Zip'
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 50,
                child: Text('Country'),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Country',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {

                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
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