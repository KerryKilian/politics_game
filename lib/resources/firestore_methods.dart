import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:politics_game/models/comment.dart';
import 'package:politics_game/models/user.dart';
import 'package:politics_game/models/message.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> changeBio(String bio, String uid) async {
    await _firestore.collection("users").doc(uid).update({
      "bio": bio,
    }).onError((e, _) => print("Error writing document: $e"));
  }

  Future<String> sendMessageToGlobalChat(Message newMessage) async {
    String res = "Ein Fehler ist aufgetreten";
    try {
      await _firestore
          .collection("chats")
          .doc("global")
          .collection("messages")
          .doc(newMessage.messageId)
          .set({
        "fromUId": newMessage.fromUId,
        "fromUsername": newMessage.fromUsername,
        "photoUrl": newMessage.photoUrl,
        "to": newMessage.to,
        "text": newMessage.text,
        "timestamp": newMessage.timestamp,
        "likes": newMessage.likes,
        "comments": newMessage.comments,
        "dislikes": newMessage.dislikes,
        "messageId": newMessage.messageId,
      });
      res = "success";
    } catch (err) {
      res = "Etwas ist schief gelaufen";
    }
    return res;
  }

  Future<String> postComment(Comment comment) async {
    String res = "Etwas ist schief gelaufen";
    try {
      if (comment.text.isNotEmpty) {
        await _firestore
            .collection("chats")
            .doc(comment.channelId)
            .collection("messages")
            .doc(comment.messageId)
            .collection("comments")
            .doc(comment.commentId)
            .set({
          "commentId": comment.commentId,
          "messageId": comment.messageId,
          "text": comment.text,
          "fromUId": comment.fromUId,
          "fromUsername": comment.fromUsername,
          "photoUrl": comment.photoUrl,
          "timestamp": comment.timestamp,
          "likes": comment.likes,
          "dislikes": comment.dislikes,
        });
        res = "Kommentar gepostet";
      }
    } catch (e) {
      print(e.toString());
      res = "Etwas ist schief gelaufen";
    }
    return res;
  }

  Future<void> likeOrDislikeMessage(String messageId, String uid, List list, String channelId, String likesOrDislikes) async {
    try {
      if (list.contains(uid)) {
        await _firestore.collection("chats").doc(channelId).collection("messages").doc(messageId).update({
          likesOrDislikes: FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection("chats").doc(channelId).collection("messages").doc(messageId).update({
          likesOrDislikes: FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }


}
