import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  InputField({Key key, this.label, this.onChanged}) : super(key: key);

  final String label;
  final void Function(String) onChanged;

  @override
  _InputFieldState createState() => _InputFieldState(
    label: label);
}

class _InputFieldState extends State<InputField> {

  String label;
  String value;
  //Function(String) onChanged;
  final TextEditingController controller = TextEditingController();

  _InputFieldState({
    this.label
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: controller.text.isEmpty ? null : IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            controller.clear();
            widget.onChanged("");
            setState(() {
             value = ""; 
            });
          },
        ),
      ),
      onChanged: (String s) {
        widget.onChanged(s);
        setState(() {
         value = s; 
        });
      },
    );
  }
}