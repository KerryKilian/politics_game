import 'package:flutter/material.dart';
import 'package:politics_game/screens/chat.dart';
import 'package:politics_game/widgets/background.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: Chat(channelId: "global"),
        ),
      ),
    );
  }
}
