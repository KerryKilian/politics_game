import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:politics_game/data/political_questions.dart';
import 'package:politics_game/resources/storage_methods.dart';
import 'package:politics_game/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String username,
    required String email,
    required String password,
    required Uint8List file,
  }) async {
    String res = "Ein Fehler ist aufgetreten";
    try {
      if (username.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);

        // add user to database
        PoliticalQuestions questions = PoliticalQuestions();
        List<int> answers = [];
        questions.questions.forEach((element) {
          answers.add(1); // neutral
        });

        model.User user = model.User(
          username: username,
          email: email,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          bio: "",
          job: "",
          politicalOrientation: 50,
          politicalAnswers: answers,
          politicalExtremism: 0,
          level: 0,
          demonstrations: [],
          partyId: "",
          followers: [],
          following: [],
        );

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        res = "Deine Email ist falsch formattiert";
      } else if (e.code == "weak-password") {
        res = "Das Password muss mindestens 6 Zeichen haben";
      } else {
        res = e.code;
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // logging user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Bitte fülle alle Felder aus.";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        res = "Benutzer nicht gefunden. Registriere dich zunächst.";
      } else if (e.code == "wrong-password") {
        res = "Falsches Passwort.";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<model.User> getUserDetails() async {
    print("getUserDetails was called now");
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection("users").doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  Future<void> signOut() async {
    _auth.signOut();
  }
}
