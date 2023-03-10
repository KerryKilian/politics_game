import 'package:flutter/material.dart';
import 'package:politics_game/models/message.dart';
import 'package:politics_game/models/user.dart';
import 'package:politics_game/providers/user_provider.dart';
import 'package:politics_game/resources/firestore_methods.dart';
import 'package:politics_game/screens/chat/comment_screen.dart';
import 'package:politics_game/utils/colors.dart';
import 'package:politics_game/widgets/custom_icon_button.dart';
import 'package:politics_game/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class MessageCard extends StatefulWidget {
  final snap;
  final uid;
  final channelId;
  final bool onCommentScreen;

  const MessageCard(
      {Key? key,
      required this.snap,
      required this.uid,
      required this.channelId,
      this.onCommentScreen = false})
      : super(key: key);

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Container(
      margin: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: widget.uid == widget.snap["fromUId"] ? 40 : 10,
          right: widget.uid == widget.snap["fromUId"] ? 10 : 40),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(
                  widget.uid == widget.snap["fromUId"] ? 10 : 0),
              bottomRight: Radius.circular(
                  widget.uid == widget.snap["fromUId"] ? 0 : 10)),
          color: widget.onCommentScreen ? Colors.blueGrey : primaryColor),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.snap["photoUrl"]),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                textAlign: TextAlign.left,
                text: widget.snap["fromUsername"],
                color: secondaryColor,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                width: 250,
                child: CustomText(
                    textAlign: TextAlign.left,
                    text: widget.snap["text"],
                    color: Colors.black,
                    maxLines: 20,
                    softWrap: true),
              ),
              SizedBox(
                height: 5,
              ),
              widget.onCommentScreen
                  ? SizedBox()
                  : Row(
                children: [
                   InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CommentScreen(
                                      snap: widget.snap,
                                      uid: widget.uid,
                                      channelId: widget.channelId,
                                    )));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.comment_sharp,
                                color: tertiaryColor,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              CustomText(
                                text: widget.snap["comments"].toString(),
                                color: tertiaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                  InkWell(
                    onTap: () async {
                      await FirestoreMethods().likeOrDislikeMessage(
                          widget.snap["messageId"],
                          user.uid,
                          widget.snap["likes"],
                          widget.channelId,
                          "likes");
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.thumb_up,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          text:
                              (widget.snap["likes"] as List).length.toString(),
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      await FirestoreMethods().likeOrDislikeMessage(
                          widget.snap["messageId"],
                          user.uid,
                          widget.snap["dislikes"],
                          widget.channelId,
                          "dislikes");
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.thumb_down,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          text: (widget.snap["dislikes"] as List)
                              .length
                              .toString(),
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
