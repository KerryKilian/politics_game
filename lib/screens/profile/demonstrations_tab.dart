import 'package:flutter/material.dart';
import 'package:politics_game/data/demonstrations.dart';
import 'package:politics_game/objects/demonstration.dart';
import 'package:politics_game/screens/profile/profile_demonstration.dart';

class DemonstrationsTab extends StatefulWidget {
  final userData;
  const DemonstrationsTab({Key? key, required this.userData}) : super(key: key);

  @override
  State<DemonstrationsTab> createState() => _DemonstrationsTabState();
}

class _DemonstrationsTabState extends State<DemonstrationsTab> {
  Demonstrations demonstrations = Demonstrations();
  List<Widget> list = <Widget>[];

  @override
  void initState() {
    super.initState();
    demonstrations.demonstrations.forEach((element) {
      list.add(Container(margin: EdgeInsets.only(top: 10),
      child: ProfileDemonstration(demonstration: element,),));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: list,
      )
    );
  }
}
