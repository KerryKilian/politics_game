import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:politics_game/objects/political_question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Party {
  final String name;
  final String partyId;
  final String photoUrl;
  final String bio;
  final List<String> members;
  final double politicalOrientation;
  final List<int> politicalAnswers;
  final double politicalExtremism;
  final List<String> demonstrations;

  const Party({
    required this.name,
    required this.partyId,
    required this.photoUrl,
    required this.bio,
    required this.members,
    required this.politicalOrientation,
    required this.politicalAnswers,
    required this.politicalExtremism,
    required this.demonstrations,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "partyId": partyId,
    "photoUrl": photoUrl,
    "bio": bio,
    "members": members,
    "politicalOrientation": politicalOrientation,
    "politicalQuestions": politicalAnswers,
    "politicalExtremism": politicalExtremism,
    "demonstrations": demonstrations,
  };

  static Party fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data as Map<String, dynamic>;

    return Party(
      name: snapshot["name"],
      partyId: snapshot["partyId"],
      photoUrl: snapshot["photoUrl"],
      bio: snapshot["bio"],
      members: snapshot["members"],
      politicalOrientation: snapshot["politicalOrientation"],
      politicalAnswers: snapshot["politicalAnswers"],
      politicalExtremism: snapshot["politicalExtremism"],
      demonstrations: snapshot["demonstrations"],
    );
  }
}