import 'package:flutter/material.dart';
import 'package:politics_game/utils/colors.dart';

class CustomText extends StatelessWidget {
  final double? fontSize;
  final bool title;
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  const CustomText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.title = false,
      this.color = primaryColor,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      textAlign: this.textAlign,
      style: TextStyle(
        fontWeight: fontWeight,
          color: this.color,
          fontSize: this.title && this.fontSize == null
              ? 24
              : this.title == false && this.fontSize != null
                  ? this.fontSize
                  : this.title == true && this.fontSize != null
                      ? this.fontSize
                      : 16),
    );
  }
}