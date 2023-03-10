import "package:flutter/material.dart";
import 'package:politics_game/screens/chat/chat.dart';
import "package:politics_game/screens/chat_screen.dart";
import 'package:politics_game/screens/party_list_screen.dart';
import "package:politics_game/screens/profile_screen.dart";
import 'package:firebase_auth/firebase_auth.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  ChatScreen(),
  PartyListScreen(),
  const Text("hello"),
  const Text("hello"),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
