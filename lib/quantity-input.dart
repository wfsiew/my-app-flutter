import 'package:flutter/material.dart';

class QuantityInput extends StatefulWidget {
  QuantityInput({Key key, this.value}) : super(key: key);

  final String value;

  @override
  _QuantityInputState createState() => _QuantityInputState(value: value);
}

class _QuantityInputState extends State<QuantityInput> {

  String value = '0';
  final TextEditingController controller = TextEditingController();

  _QuantityInputState({
    this.value
  });

  @override
  void initState() {
    super.initState();
    controller.text = value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.remove),
          color: Colors.red,
          onPressed: () {
            // int x = int.parse(value);
            // if (x > 0) {
            //   x--;
            // }
            // setState(() {
            //  value = x.toString(); 
            // });
          },
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'Quantity'
          ),
          onChanged: (String s) {
            setState(() {
             value = s; 
            });
          },
          controller: controller,
        ),
        IconButton(
          icon: Icon(Icons.add),
          color: Colors.red,
          onPressed: () {
            int x = int.parse(value);
            x++;
            setState(() {
             value = x.toString(); 
            });
          },
        ),
      ],
    );
  }
}