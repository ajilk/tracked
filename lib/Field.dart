import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  final String text;
  final String hintText;
  final TextInputType keyboardType;
  Field(
      {this.text = '',
      this.hintText = ' [ N / A ] ',
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    int getMaxLines() => keyboardType == TextInputType.multiline ? 10 : 1;

    final field = TextField(
      keyboardType: keyboardType,
      maxLines: getMaxLines(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );

    final fieldInfo = Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(text),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Visibility(visible: text.isNotEmpty, child: fieldInfo),
          field
        ],
      ),
    );
  }
}
