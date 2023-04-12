import 'package:flutter/material.dart';

class PoliticalQuestion {
  final String question;
  late int answer;
  final List<double> capitalistPoints; // 3 Elemente mit Punkten: -5: links; 0: mitte; +5: rechts
  final List<double> conservativePoints;
  final List<double> extremistPoints; // wie extremistisch ist jemand eingestellt?

  PoliticalQuestion({required this.question, required this.capitalistPoints, required this.conservativePoints,required this.extremistPoints});

  /**
   * returns a list of two elements:
   * 1: points of political orientation: negative means left, positive means right
   * 2: points of extremistic orientation: negative means no extremistic, positive means extremistic.
   */
  List<double> setAnswer(int answer) {
    this.answer = answer;
    return [this.capitalistPoints[answer], this.conservativePoints[answer], this.extremistPoints[answer]];
  }

  String get title {
    return this.question;
  }

}