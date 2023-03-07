import 'package:flutter/material.dart';
import 'package:politics_game/utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String text;
  final TextInputType textInputType;
  final bool obscureText;
  final int maxLines;
  const TextFieldInput({Key? key, required this.textEditingController, required this.text, required this.textInputType, this.obscureText = false, this.maxLines = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10,0,10,0),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: secondaryColor),
      ),

      child: TextField(
        style: TextStyle(color: secondaryColor),
        decoration: InputDecoration(
          labelStyle: TextStyle(
            color: secondaryColor,
          ),
          border: InputBorder.none,
          labelText: this.text,
        ),
        controller: textEditingController,
        keyboardType: this.textInputType,
        obscureText: this.obscureText,
        maxLines: maxLines,
      ),
    );
  }
}
