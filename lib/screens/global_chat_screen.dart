import 'package:flutter/material.dart';
import 'package:politics_game/widgets/background.dart';

class GlobalChatScreen extends StatefulWidget {
  const GlobalChatScreen({Key? key}) : super(key: key);

  @override
  State<GlobalChatScreen> createState() => _GlobalChatScreenState();
}

class _GlobalChatScreenState extends State<GlobalChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Text("Hllo"),
      ),
    );
  }
}
