import 'package:flutter/material.dart';
import 'package:politics_game/objects/political_question.dart';
import 'package:politics_game/utils/colors.dart';
import 'package:politics_game/widgets/custom_text.dart';

class ProfileQuestion extends StatefulWidget {
  final PoliticalQuestion politicalQuestion;

  const ProfileQuestion({Key? key, required this.politicalQuestion})
      : super(key: key);

  @override
  State<ProfileQuestion> createState() => _ProfileQuestionState();
}

class _ProfileQuestionState extends State<ProfileQuestion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          CustomText(
            text: widget.politicalQuestion.title,
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CustomText(
                  text: "Ja",
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomText(
                  text: "Vielleicht",
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomText(
                  text: "Nein",
                  color: Colors.black,
                ),
              ),
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(8)),
          color: primaryColor),
    );
  }
}
