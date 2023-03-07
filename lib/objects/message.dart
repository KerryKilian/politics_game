import 'package:flutter/material.dart';

class Message {
  final String from;
  final String to;
  late DateTime timestamp;
  final String text;
  final String channelId;

  Message({required this.from, required this.to, required this.text, required this.channelId});



}