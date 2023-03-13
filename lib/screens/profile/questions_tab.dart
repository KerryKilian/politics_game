import 'package:flutter/material.dart';
import 'package:politics_game/data/political_questions.dart';
import 'package:politics_game/objects/political_question.dart';
import 'package:politics_game/screens/profile/profile_question.dart';

class QuestionsTab extends StatefulWidget {
  const QuestionsTab({Key? key}) : super(key: key);

  @override
  State<QuestionsTab> createState() => _QuestionsTabState();
}

class _QuestionsTabState extends State<QuestionsTab> {
  PoliticalQuestions questions = PoliticalQuestions();
  List<Widget> list = <Widget>[];

  @override
  void initState() {
    super.initState();
    questions.questions.forEach((element) {
      // list.add(ListTile(title: Text(element.title)));
      list.add(Container(
        margin: EdgeInsets.only(top: 10),
        child: ProfileQuestion(
          politicalQuestion: element,
        ),
      ));
    });
  }

  // listArray.add(new ListTile(title: new Text(value[i].name));

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: list,
      ),
    );
  }
}
