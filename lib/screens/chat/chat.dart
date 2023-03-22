import 'package:flutter/material.dart';
import 'package:politics_game/models/user.dart' as model;
import 'package:politics_game/models/message.dart';
import 'package:politics_game/providers/user_provider.dart';
import 'package:politics_game/resources/auth_methods.dart';
import 'package:politics_game/resources/firestore_methods.dart';
import 'package:politics_game/utils/colors.dart';
import 'package:politics_game/widgets/background.dart';
import 'package:politics_game/widgets/custom_icon_button.dart';
import 'package:politics_game/screens/chat/message_card.dart';
import 'package:politics_game/widgets/text_field_input.dart';
import "package:provider/provider.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  final String channelId;

  const Chat({Key? key, required this.channelId}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController _textEditingController = TextEditingController();
  bool messageAsParty = false;

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   print("initState was called now");
  //   addData();
  // }
  //
  // addData() async {
  //   UserProvider _userProvider = Provider.of<UserProvider>(context, listen: false);
  //   await _userProvider.refreshUser();
  // }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    // User? user = FirebaseAuth.instance.currentUser;
    // print(user.partyId);

    return Scaffold(
      body: SafeArea(
        child: Background(
            child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("chats")
                  .doc(widget.channelId)
                  .collection("messages")
                  .orderBy("timestamp", descending: true)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => MessageCard(
                    snap: snapshot.data!.docs[index].data(),
                    uid: user.uid,
                    channelId: widget.channelId,
                  ),
                  reverse: true,
                );
              },
            )),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextFieldInput(
                            textEditingController: _textEditingController,
                            text: messageAsParty ? "Nachricht als Partei" : "Nachricht als 'ich'",
                            textInputType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 5,
                          )),
                          Checkbox(
                            checkColor: Colors.white,
                            value: messageAsParty,
                            onChanged: (bool? value) {
                              setState(() {
                                messageAsParty = !messageAsParty;
                              });
                            },
                          ),
                          Container(
                              margin: EdgeInsets.all(10),
                              child: CustomIconButton(
                                icon: Icons.send,
                                onTap: () {
                                  FirestoreMethods()
                                      .sendMessageToGlobalChat(Message(
                                    fromUId: user!.uid,
                                    fromUsername: user.username,
                                    fromPartyId: user.partyId,
                                    to: "global",
                                    text: _textEditingController.text,
                                    channelId: "global",
                                    messageId: const Uuid().v1(),
                                    timestamp: DateTime.now(),
                                    photoUrl: user.photoUrl,
                                    comments: 0,
                                    likes: [],
                                    dislikes: [],
                                    messageAsParty: messageAsParty,
                                  ));
                                  _textEditingController.text = "";
                                },
                              )),
                        ],
                      ),
                    ),
                  ]))
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
