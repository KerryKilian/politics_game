import 'package:flutter/material.dart';
import 'package:politics_game/data/political_questions.dart';
import 'package:politics_game/objects/political_question.dart';
import 'package:politics_game/screens/profile/profile_question.dart';
import 'package:politics_game/screens/profile_screen.dart';
import 'package:politics_game/utils/colors.dart';
import 'package:politics_game/widgets/custom_button.dart';
import 'package:politics_game/resources/firestore_methods.dart';

class QuestionsTab extends StatefulWidget {
  final List userAnswers;
  final String id;

  const QuestionsTab({Key? key, required this.userAnswers, required this.id})
      : super(key: key);

  @override
  State<QuestionsTab> createState() => _QuestionsTabState();
}

class _QuestionsTabState extends State<QuestionsTab> {
  PoliticalQuestions questions = PoliticalQuestions();
  List<Widget> list = <Widget>[];
  List<int> politicalAnswers = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    questions.questions.asMap().forEach((index, element) {
      list.add(Container(
        margin: EdgeInsets.only(top: 10),
        child: ProfileQuestion(
          politicalQuestion: element,
          selected: widget.userAnswers[index],
          index: index,
          setAnswer: setAnswer
        ),
      ));
      politicalAnswers.add(widget.userAnswers[index]);
    });
  }

  void setAnswer(int index, int selected) {
    politicalAnswers[index] = selected;
  }

  void setAnswersInDB() async {
    print("XXX");
    print(widget.userAnswers);
    setState(() {
      _isLoading = true;
    });
    await FirestoreMethods().setPoliticalAnswers(widget.id, politicalAnswers);
    setState(() {
      _isLoading = false;
    });
    print(widget.userAnswers);

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        _isLoading ? CircularProgressIndicator(color: fifthColor,) : SizedBox(height: 1,),
        CustomButton(text: "Speichern", onTapFunction: setAnswersInDB),
        Expanded(
          child: ListView(
            children: list,
          ),
        ),
      ],
    );
  }
}
