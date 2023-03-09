import 'package:flutter/material.dart';
import 'package:politics_game/objects/political_question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String email;
  final String uid;
  final String photoUrl;
  final String bio;
  final String job;
  final num politicalOrientation;
  final List politicalAnswers;
  final num politicalExtremism;
  final num level;
  final String partyId;
  final List demonstrations;
  final List followers;
  final List following;

  const User({
    required this.username,
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.bio,
    required this.job,
    required this.politicalOrientation,
    required this.politicalAnswers,
    required this.level,
    required this.politicalExtremism,
    required this.partyId,
    required this.demonstrations,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "uid": uid,
        "photoUrl": photoUrl,
        "bio": bio,
        "job": job,
        "politicalOrientation": politicalOrientation,
        "politicalAnswers": politicalAnswers,
        "level": level,
        "politicalExtremism": politicalExtremism,
        "partyId": partyId,
        "demonstrations": demonstrations,
        "followers": followers,
        "following": following,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      email: snapshot["email"],
      uid: snapshot["uid"],
      photoUrl: snapshot["photoUrl"],
      bio: snapshot["bio"],
      job: snapshot["job"],
      politicalOrientation: snapshot["politicalOrientation"],
      politicalAnswers: snapshot["politicalAnswers"],
      level: snapshot["level"],
      politicalExtremism: snapshot["politicalExtremism"],
      partyId: snapshot["partyId"],
      demonstrations: snapshot["demonstrations"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }
}
