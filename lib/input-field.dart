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
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  _InputFieldState({
    this.label
  });

  void onChange() {
    String text = controller.text;
    bool hasFocus = focusNode.hasFocus;
    if (text.length > 0) {
      controller.selection = TextSelection(
        baseOffset: text.length,
        extentOffset: text.length
      );
    }

    else {
      controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: 0
      );
    }
    
    widget.onChanged(text);
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(onChange);
    focusNode.addListener(onChange);
  }

  @override
  void dispose() {
    controller.removeListener(onChange);
    focusNode.removeListener(onChange);
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              controller.clear();
            });
            widget.onChanged("");
          },
        )
      ),
    );
  }
}