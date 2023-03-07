import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:politics_game/objects/message.dart';

class Channel {
  final String channelId;
  final List<String> members;
  final List<Message> messages;

  const Channel({
    required this.channelId,
    required this.members,
    required this.messages,
  });

  Map<String, dynamic> toJson() => {
    "channelId": channelId,
    "members": members,
    "timestamp": messages,
  };

  static Channel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data as Map<String, dynamic>;

    return Channel(
      channelId: snapshot["channelId"],
      members: snapshot["members"],
      messages: snapshot["messages"],
    );
  }
}
