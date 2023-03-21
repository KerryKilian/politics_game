import 'package:flutter/material.dart';

class Message {
  final String fromUId;
  final String fromUsername;
  final String fromPartyId;
  final String to;
  late DateTime timestamp;
  final String text;
  final String channelId;
  final String messageId;
  final String photoUrl;
  final bool messageAsParty;
  late num comments;
  late List likes;
  late List dislikes;


  Message({
    required this.fromUId,
    required this.fromUsername,
    required this.fromPartyId,
    required this.to,
    required this.text,
    required this.channelId,
    required this.messageId,
    required this.timestamp,
    required this.photoUrl,
    required this.comments,
    required this.likes,
    required this.dislikes,
    required this.messageAsParty,
  });
}
