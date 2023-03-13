import 'package:flutter/material.dart';
import 'package:politics_game/models/comment.dart';
import 'package:politics_game/models/message.dart';
import 'package:politics_game/models/user.dart';
import 'package:politics_game/providers/user_provider.dart';
import 'package:politics_game/resources/firestore_methods.dart';
import 'package:politics_game/utils/colors.dart';
import 'package:politics_game/widgets/background.dart';
import 'package:politics_game/widgets/custom_icon_button.dart';
import 'package:politics_game/widgets/custom_text.dart';
import 'package:politics_game/screens/chat/message_card.dart';
import 'package:politics_game/widgets/text_field_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  final uid;
  final channelId;

  const CommentScreen(
      {Key? key,
      required this.snap,
      required this.uid,
      required this.channelId})
      : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController _commentEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: SafeArea(
        child: Background(
          child: Column(
            children: [
              Row(children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: CustomIconButton(
                      icon: Icons.arrow_back,
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                ),
                
                Center(
                  child: CustomText(
                    textAlign: TextAlign.center,
                    text: "Kommentare",
                    title: true,
                  ),
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              MessageCard(
                snap: widget.snap,
                uid: widget.uid,
                channelId: widget.channelId,
                onCommentScreen: true,
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chats")
                    .doc(widget.channelId)
                    .collection("messages")
                    .doc(widget.snap["messageId"])
                    .collection("comments")
                    .orderBy("timestamp", descending: false)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => MessageCard(
                      snap: snapshot.data!.docs[index].data(),
                      uid: widget.uid,
                      channelId: widget.channelId,
                      onCommentScreen: true,
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
                              textEditingController: _commentEditingController,
                              text: "Nachricht an alle",
                              textInputType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 5,
                            )),
                            Container(
                                margin: EdgeInsets.all(10),
                                child: CustomIconButton(
                                  icon: Icons.send,
                                  onTap: () async {
                                    String res = await FirestoreMethods()
                                        .postComment(Comment(
                                            text:
                                                _commentEditingController.text,
                                            fromUId: user.uid,
                                            fromUsername: user.username,
                                            photoUrl: user.photoUrl,
                                            timestamp: DateTime.now(),
                                            likes: [],
                                            dislikes: [],
                                            commentId: Uuid().v1(),
                                            messageId: widget.snap["messageId"],
                                            channelId: widget.channelId));
                                    _commentEditingController.text = "";
                                    print(res);
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
          ),
        ),
      ),
    );
  }
}
