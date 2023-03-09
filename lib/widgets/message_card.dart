import 'package:flutter/material.dart';
import 'package:politics_game/models/message.dart';
import 'package:politics_game/screens/comment_screen.dart';
import 'package:politics_game/utils/colors.dart';
import 'package:politics_game/widgets/custom_icon_button.dart';
import 'package:politics_game/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
              widget.onCommentScreen
                  ? SizedBox(
                      height: 0,
                    )
                  : InkWell(
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
                          Row(
                            children: [
                              CustomIconButton(
                                icon: Icons.comment_sharp,
                                onTap: () {},
                                colorOne: primaryColor,
                                colorTwo: primaryColor,
                                iconSize: 20,
                                padding: 5,
                                iconColor: tertiaryColor,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              CustomText(
                                text: widget.snap["comments"].toString(),
                                color: tertiaryColor,
                              ),
                            ],
                          )
                        ],
                      )),
            ],
          ),
        ],
      ),
    );
  }
}
