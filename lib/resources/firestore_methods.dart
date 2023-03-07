import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:politics_game/models/user.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> changeBio(String bio, String uid) async {
    _firestore.collection("users").doc(uid).update({
      "bio": bio,
    }).onError((e, _) => print("Error writing document: $e"));
  }
}
