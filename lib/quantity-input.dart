import 'package:flutter/material.dart';

class QuantityInput extends StatefulWidget {
  QuantityInput({Key key, this.value, this.productID, this.onQuantityChanged}) : super(key: key);

  final String value;
  final int productID;
  final void Function(int, int) onQuantityChanged;

  @override
  _QuantityInputState createState() => _QuantityInputState(
    value: value, 
    productID: productID, 
    onQuantityChanged: onQuantityChanged);
}

class _QuantityInputState extends State<QuantityInput> {

  String value = '0';
  int productID;
  Function(int, int) onQuantityChanged;
  final TextEditingController controller = TextEditingController();

  _QuantityInputState({
    this.value,
    this.productID,
    this.onQuantityChanged
  });

  void minusQty() {
    int x = int.tryParse(value) ?? 1;
    if (x > 1) {
      x--;
    }
    upDateTextQty(x);
  }

  void addQty() {
    int x = int.tryParse(value) ?? 1;
    x++;
    upDateTextQty(x);
  }

  void setQty(String s) {
    int x = int.tryParse(s) ?? 1;
    String v = x.toString();
    upDateTextQty(x);
  }

  void upDateTextQty(int quantity) {
    String v = '$quantity';
    controller.text = v;
    widget.onQuantityChanged(productID, quantity);
    setState(() {
     value = v;
    });
  }

  @override
  void initState() {
    super.initState();
    controller.text = value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(icon: Icon(Icons.remove), color: Colors.red,
          onPressed: value == '1' ? null : minusQty,
        ),
        SizedBox(
          width: 30,
          height: 20,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Qty'
            ),
            onChanged: setQty,
          ),
        ),
        IconButton(icon: Icon(Icons.add), color: Colors.red,
          onPressed: addQty,
        ),
      ],
    );
  }
}