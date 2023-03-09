import 'package:flutter/material.dart';

class Comment {
  final String text;
  final String fromUId;
  final String fromUsername;
  final String photoUrl;
  final DateTime timestamp;
  final List likes;
  final List dislikes;
  final String commentId;
  final String messageId;
  final String channelId;

  Comment({required this.text,
    required this.fromUId,
    required this.fromUsername,
    required this.photoUrl,
    required this.timestamp,
    required this.likes,
    required this.dislikes,
    required this.commentId,
    required this.messageId,
    required this.channelId,
  });
}
