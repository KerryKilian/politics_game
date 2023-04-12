import 'package:flutter/material.dart';
import 'package:politics_game/data/political_questions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class UploadQuestionsScreen extends StatefulWidget {
  const UploadQuestionsScreen({Key? key}) : super(key: key);

  @override
  State<UploadQuestionsScreen> createState() => _UploadQuestionsScreenState();
}

class _UploadQuestionsScreenState extends State<UploadQuestionsScreen> {
  PoliticalQuestions questions = PoliticalQuestions();
  List<Widget> list = <Widget>[];

  @override
  void initState() {
    super.initState();
    questions.questions.forEach((element) {
      // list.add(ListTile(title: Text(element.title)));
      String id = Uuid().v1();
      FirebaseFirestore.instance.collection("questions").doc(id).set(
        {
          "question": element.question,
          "politicalPoints": element.capitalistPoints,
          "extremistPoints": element.extremistPoints
        }
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
