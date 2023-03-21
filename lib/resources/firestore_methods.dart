import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:politics_game/data/political_questions.dart';
import 'package:politics_game/models/comment.dart';
import 'package:politics_game/models/party.dart';
import 'package:politics_game/models/user.dart';
import 'package:politics_game/models/message.dart';
import 'package:politics_game/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> changeBio(String bio, String uid, String userOrParty) async {
    await _firestore.collection(userOrParty).doc(uid).update({
      "bio": bio,
    }).onError((e, _) => print("Error writing document: $e"));
  }
  
  Future<void> updateProfile(String key, String value, String id, bool user) async {
    await _firestore.collection(user ? "users" : "parties").doc(id).update({
      key: value,
    }).onError((error, stackTrace) => print("Error writing document: $error"));
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
        "fromPartyId": newMessage.fromPartyId,
        "photoUrl": newMessage.photoUrl,
        "to": newMessage.to,
        "text": newMessage.text,
        "timestamp": newMessage.timestamp,
        "likes": newMessage.likes,
        "comments": newMessage.comments,
        "dislikes": newMessage.dislikes,
        "messageId": newMessage.messageId,
        "messageAsParty": newMessage.messageAsParty,
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

  Future<void> likeOrDislikeMessage(String messageId, String uid, List list,
      String channelId, String likesOrDislikes) async {
    try {
      if (list.contains(uid)) {
        await _firestore
            .collection("chats")
            .doc(channelId)
            .collection("messages")
            .doc(messageId)
            .update({
          likesOrDislikes: FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore
            .collection("chats")
            .doc(channelId)
            .collection("messages")
            .doc(messageId)
            .update({
          likesOrDislikes: FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> foundParty(String name, String slogan, String bio, String shortName, String uid,
      Uint8List file, DateTime foundingDate, String color) async {
    PoliticalQuestions questions = PoliticalQuestions();
    List<int> answers = [];
    questions.questions.forEach((element) {
      answers.add(1); // neutral
    });

    String photoUrl =
        await StorageMethods().uploadImageToStorage("profilePics", file, false);

    String partyId = Uuid().v1();

    await _firestore.collection("parties").doc(partyId).set({
      "name": name,
      "partyId": partyId,
      "photoUrl": photoUrl,
      "slogan": slogan,
      "bio": bio,
      "shortName": shortName,
      "members": [uid],
      "politicalAnswers": answers,
      "politicalOrientation": 50,
      "politicalExtremism": 0,
      "demonstrations": [],
      "level": 0,
      "founderId": uid,
      "foundingDate": foundingDate,
      "color": color,
    });
    // Update partyid in user data
    await updateProfile("partyId", partyId, uid, true);

  }
}
