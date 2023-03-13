import 'package:flutter/material.dart';
import 'package:politics_game/objects/demonstration.dart';
import 'package:politics_game/utils/colors.dart';
import 'package:politics_game/widgets/custom_text.dart';
import 'package:intl/intl.dart';


class ProfileDemonstration extends StatelessWidget {
  final Demonstration demonstration;
  const ProfileDemonstration({Key? key, required this.demonstration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(8)),
          color: primaryColor),
      child: Column(
        children: [
          CustomText(text: demonstration.title, color: Colors.black,),
          CustomText(text: "Am: " + DateFormat.yMMMd().format(demonstration.started), color: Colors.black,),
        ],
      ),
    );
  }
}
