import "package:flutter/material.dart";
import "package:politics_game/screens/chat/message_card.dart";
import "package:politics_game/utils/utils.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesTab extends StatefulWidget {
  final String id;
  final bool user;
  const MessagesTab({Key? key, required this.id, required this.user}) : super(key: key);

  @override
  State<MessagesTab> createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab> {

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Container(
      child: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("chats")
                    .doc("global")
                    .collection("messages")
                    .where(widget.user ? "fromUId" : "fromPartyId", isEqualTo: widget.id)
                    .orderBy("timestamp")
                    .snapshots(),
                builder: (context, AsyncSnapshot<
                    QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) =>
                      MessageCard(snap: snapshot.data!.docs[index].data(),
                          uid: widget.id,
                          channelId: "global"));
                },
              )
          ),
        ],
      ),
    );
  }
}
