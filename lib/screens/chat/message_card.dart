import 'package:flutter/material.dart';
import 'package:politics_game/models/message.dart';
import 'package:politics_game/models/user.dart';
import 'package:politics_game/providers/user_provider.dart';
import 'package:politics_game/resources/firestore_methods.dart';
import 'package:politics_game/screens/chat/comment_screen.dart';
import 'package:politics_game/utils/colors.dart';
import 'package:politics_game/utils/utils.dart';
import 'package:politics_game/widgets/custom_icon_button.dart';
import 'package:politics_game/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:tinycolor2/tinycolor2.dart';

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
  String? partyPhotoUrl = null;
  Color backgroundColor = primaryColor;
  String? userPhotoUrl = null;
  Color? partyColor = null;

  @override
  void initState() {
    super.initState();
    print("MESSAGE CARD");

    getData();
  }

  /**
   * gets user and party information from the sending person
   */
  void getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.snap["fromUId"])
          .get();
      var userData = await userSnap.data();
      userPhotoUrl = userData!["photoUrl"];
    } catch (e) {
      print(e.toString());
    }
    try {
      var partySnap = await FirebaseFirestore.instance
          .collection("parties")
          .doc(widget.snap["fromPartyId"])
          .get();

      var partyData = await partySnap.data();

      partyPhotoUrl = partyData!["photoUrl"];
      partyColor = Color(int.parse('FF${partyData["color"]}', radix: 16));
      partyColor = TinyColor.fromColor(partyColor!).lighten(40).toColor();
      if (TinyColor.fromColor(partyColor!).isDark()) {
        partyColor = TinyColor.fromColor(partyColor!).lighten(40).toColor();
      }


    } catch (e) {
      print(e.toString());
    }
    setState(() {});

  }

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
          gradient: LinearGradient(colors: [
            partyColor != null ? TinyColor.fromColor(partyColor!).spin(50).toColor() : primaryColor,
            partyColor != null ? partyColor! : primaryColor
          ], begin: Alignment.centerRight
          , end: Alignment.centerLeft)),
      // color: widget.onCommentScreen ? Colors.blueGrey : partyColor),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              userPhotoUrl != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(userPhotoUrl!),
                    )
                  : CircularProgressIndicator(),
              // CircleAvatar(
              //   backgroundImage: NetworkImage(widget.snap["photoUrl"]),
              // ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 40,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: partyPhotoUrl != null
                          ? Image.network(
                              partyPhotoUrl!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/images/grau_kreuz.png",
                              fit: BoxFit.cover,
                            )),
                ),
              )
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  textAlign: TextAlign.left,
                  text: widget.snap["fromUsername"],
                  color: secondaryColor,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CommentScreen(
                              snap: widget.snap,
                              uid: widget.uid,
                              channelId: widget.channelId,
                            )));
                  },
                  child: CustomText(
                      textAlign: TextAlign.left,
                      text: widget.snap["text"],
                      color: Colors.black,
                      fontSize: 14,
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
                                  text: (widget.snap["likes"] as List)
                                      .length
                                      .toString(),
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
          ),
        ],
      ),
    );
  }
}
