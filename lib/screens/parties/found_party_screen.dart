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
import 'package:politics_game/widgets/custom_text.dart';
import 'package:politics_game/widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';
import "package:provider/provider.dart";

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
                      CustomText(
                        text: "Eigene Partei gründen",
                        title: true,
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
                              textEditingController:
                              _sloganEditingController,
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
                                  DateTime.now());
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
