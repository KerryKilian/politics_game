import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:politics_game/models/party.dart';
import 'package:politics_game/models/user.dart';
import 'package:politics_game/providers/user_provider.dart';
import 'package:politics_game/resources/firestore_methods.dart';
import 'package:politics_game/utils/colors.dart';
import 'package:politics_game/utils/utils.dart';
import 'package:politics_game/widgets/background.dart';
import 'package:politics_game/widgets/custom_button.dart';
import 'package:politics_game/widgets/custom_icon_button.dart';
import 'package:politics_game/widgets/custom_text.dart';
import 'package:politics_game/widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';
import "package:provider/provider.dart";
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class FoundPartyScreen extends StatefulWidget {
  @override
  State<FoundPartyScreen> createState() => _FoundPartyScreenState();
}

class _FoundPartyScreenState extends State<FoundPartyScreen> {
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _sloganEditingController = TextEditingController();
  TextEditingController _shortNameEditingController = TextEditingController();
  TextEditingController _bioEditingController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  Color myColor = Colors.deepOrangeAccent;

  @override
  void dispose() {
    super.dispose();
    _nameEditingController.dispose();
    _bioEditingController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: SafeArea(
        child: Background(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            CustomIconButton(icon: Icons.arrow_back, onTap: () {
                              Navigator.of(context).pop();
                            }),
                            SizedBox(width: 10,),
                            Expanded(
                              child: CustomText(
                                text: "Eigene Partei gründen",
                                title: true,
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFieldInput(
                              textEditingController: _nameEditingController,
                              text: "Parteiname",
                              textInputType: TextInputType.text)),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFieldInput(
                              textEditingController:
                                  _shortNameEditingController,
                              text: "Abkürzung",
                              maxLength: 4,
                              textInputType: TextInputType.text)),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFieldInput(
                              textEditingController: _sloganEditingController,
                              text: "Prägnanter Spruch",
                              maxLength: 40,
                              textInputType: TextInputType.text)),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFieldInput(
                            textEditingController: _bioEditingController,
                            text: "Beschreibung",
                            textInputType: TextInputType.multiline,
                            minLines: 5,
                            maxLines: 5,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: selectImage,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 100),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: _image != null
                                    ? Image.memory(
                                        _image!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        "assets/images/logo_vorlage.png",
                                        fit: BoxFit.cover,
                                      )),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIconButton(
                                icon: Icons.square,
                                colorOne: myColor,
                                colorTwo: myColor,
                                iconColor: myColor,
                                onTap: () {}),
                            SizedBox(
                              width: 10,
                            ),
                            CustomButton(
                                text: "Farbe wählen",
                                onTapFunction: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Wähle eine Parteifarbe'),
                                          content: SingleChildScrollView(
                                            child: ColorPicker(
                                              pickerColor:
                                                  myColor, //default color
                                              onColorChanged: (Color color) {
                                                //on color picked
                                                setState(() {
                                                  myColor = color;
                                                  print(myColor.value.toRadixString(16).substring(2));
                                                });
                                              },
                                            ),
                                          ),
                                          actions: <Widget>[
                                            CustomButton(
                                                text: "Fertig",
                                                onTapFunction: () {
                                                  Navigator.of(context).pop();
                                                })
                                          ],
                                        );
                                      });
                                })
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: CustomButton(
                            text: "Bestätigen",
                            onTapFunction: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              await FirestoreMethods().foundParty(
                                  _nameEditingController.text,
                                  _sloganEditingController.text,
                                  _bioEditingController.text,
                                  _shortNameEditingController.text,
                                  user.uid,
                                  _image!,
                                  DateTime.now(),
                                  myColor.value.toRadixString(16).substring(2));

                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.of(context).pop();
                            }),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
