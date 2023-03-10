import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:politics_game/utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String text;
  final TextInputType textInputType;
  final bool obscureText;
  final int minLines;
  final int maxLines;
  final Color labelColor;
  final int? maxLength;

  const TextFieldInput(
      {Key? key,
      required this.textEditingController,
      required this.text,
      required this.textInputType,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines = 1,
      this.labelColor = secondaryColor,
      this.maxLength = null,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelStyle: TextStyle(
            color: labelColor,
          ),
          border: InputBorder.none,
          labelText: this.text,
        ),
        controller: textEditingController,
        keyboardType: this.textInputType,
        obscureText: this.obscureText,
        minLines: minLines,
        maxLines: maxLines,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,

      ),
    );
  }
}
