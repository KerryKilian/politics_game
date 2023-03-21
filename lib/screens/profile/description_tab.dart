import 'package:flutter/material.dart';
import 'package:politics_game/resources/firestore_methods.dart';
import 'package:politics_game/widgets/custom_button.dart';
import 'package:politics_game/widgets/custom_text.dart';
import 'package:politics_game/widgets/text_field_input.dart';


class DescriptionTab extends StatefulWidget {
  final snap;
  final bool party;

  const DescriptionTab({Key? key, required this.snap, required this.party}) : super(key: key);

  @override
  State<DescriptionTab> createState() => _DescriptionTabState();
}

class _DescriptionTabState extends State<DescriptionTab> {
  bool _isEditingBio = false;
  TextEditingController _bioEditingController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    _bioEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bioEditingController.text = widget.snap["bio"];

    return Container(
        padding: EdgeInsets.all(10),
        child:
        _isEditingBio == false ? Column(
          children: [

            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: CustomButton(
                  text: "Beschreibung ändern",
                  onTapFunction: () {

                    setState(() {
                      _isEditingBio = true;
                    });
                  }),
            ),
            SizedBox(height: 10,),
            CustomText(textAlign: TextAlign.left, text: widget.snap["bio"])

          ],
        ) : Column(
          children: [
            CustomButton(text: "Fertig", onTapFunction: () async {
              await FirestoreMethods().changeBio(_bioEditingController.text, widget.party ? widget.snap["partyId"] : widget.snap["uid"], widget.party ? "parties" : "users");
              setState(() {
                _isEditingBio = false;
              });
            }),
            SizedBox(height: 5,),
            TextFieldInput(textEditingController: _bioEditingController,
              text: "Profilbeschreibung",
              textInputType: TextInputType.multiline,
              maxLines: 10,
            ),
          ],
        )
    );
  }
}
