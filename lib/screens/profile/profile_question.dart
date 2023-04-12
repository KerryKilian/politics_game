import 'package:flutter/material.dart';
import 'package:politics_game/objects/political_question.dart';
import 'package:politics_game/utils/colors.dart';
import 'package:politics_game/widgets/custom_text.dart';

class ProfileQuestion extends StatefulWidget {
  final PoliticalQuestion politicalQuestion;
  late int selected;
  final int index;
  final Function setAnswer;

  ProfileQuestion({Key? key, required this.politicalQuestion, required this.selected, required this.index, required this.setAnswer})
      : super(key: key);

  @override
  State<ProfileQuestion> createState() => _ProfileQuestionState();
}

class _ProfileQuestionState extends State<ProfileQuestion> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.topLeft,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(8)),
          color: primaryColor),
      child: Column(
        children: [
          CustomText(
            text: widget.politicalQuestion.title,
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [


                Expanded(
                  flex: 1,
                    child: InkWell(
                      onTap: () {
                        widget.setAnswer(widget.index, 0);
                        setState(() {
                          widget.selected = 0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: widget.selected == 0 ? fourthColor : Colors.white,
                        child: const CustomText(
                          text: "Ja",
                          color: Colors.black,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                ),

              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    widget.setAnswer(widget.index, 1);
                    setState(() {
                      widget.selected = 1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: widget.selected == 1 ? fourthColor : Colors.white,
                    child: const CustomText(
                      text: "Vielleicht",
                      color: Colors.black,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    widget.setAnswer(widget.index, 2);
                    setState(() {
                      widget.selected = 2;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: widget.selected == 2 ? fourthColor : Colors.white,
                    child: const CustomText(
                      text: "Nein",
                      color: Colors.black,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

              ),
            ],
          )
        ],
      ),
    );
  }
}
