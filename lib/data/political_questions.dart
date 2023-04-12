import 'dart:core';

import 'package:flutter/material.dart';
import 'package:politics_game/objects/political_question.dart';

class PoliticalQuestions {
  List<PoliticalQuestion> get questions => [
    // [Ja, Vielleicht, Nein]
    // -1 : unbedeutend für diese Frage
    PoliticalQuestion(
        question: "Ein reiches Land muss Entwicklungshilfe an bedürftige Staaten leisten.",
        capitalistPoints: [20, 50, 70],
        conservativePoints: [30, 50, 75],
        extremistPoints: [0, 0, 0]),
    PoliticalQuestion(
        question: "Wir müssen Einwanderung zulassen und bedürftigen Menschen Asyl bieten.",
        capitalistPoints: [30, 50, 60],
        conservativePoints: [20, 50, 80],
        extremistPoints: [0, 0, 0]),
    PoliticalQuestion(question: "Marihuana sollte legalisiert werden",
        capitalistPoints: [50, 50, 45],
        conservativePoints: [10, 50, 90],
        extremistPoints: [0, 0, 0]),
    PoliticalQuestion(
        question: "Der Staat muss Geld von reichen Menschen zu armen Menschen umverteilen",
        capitalistPoints: [0,50,100],
        conservativePoints: [-1, -1, -1],
        extremistPoints: [0,0,0]),
    PoliticalQuestion(question: "Der Staat soll in den Markt eingreifen, wenn es nötig ist, die Umwelt zu schützen oder soziale Armut zu bekämpfen",
        capitalistPoints: [0,50,100],
        conservativePoints: [-1, -1, -1],
        extremistPoints: [0,0,0]),
    PoliticalQuestion(question: "Kulturelle Minderheiten dürfen weniger Rechte haben",
        capitalistPoints: [20,60,70],
        conservativePoints: [100, 70, 0],
        extremistPoints: [10,5,0]),






    // HIER WEITERMACHEN
    PoliticalQuestion(question: "Es muss ein Maximalgehalt von Löhnen in einem Vorstand geben",
        capitalistPoints: [10,50,90],
        conservativePoints: [40, 50, 75],
        extremistPoints: [0,0,0]),
    PoliticalQuestion(question: "Allen Menschen muss eine kostenlose Gesundheitsversorgung zustehen",
        capitalistPoints: [15,50,85],
        conservativePoints: [40, 50, 60],
        extremistPoints: [0,0,0]),
    PoliticalQuestion(question: "Unser Staat hat natürliche Feinde.",
        capitalistPoints: [-1,-1,-1],
        conservativePoints: [80, 50, 0],
        extremistPoints: [20,10,0]),
    PoliticalQuestion(question: "Das gewählte Staatsoberhaupt darf andere Meinungen unterdrücken",
        capitalistPoints: [-1,-1,-1],
        conservativePoints: [-1, -1, 0],
        extremistPoints: [20,10,0]),
    PoliticalQuestion(question: "Das oberste Ziel eines Präsidenten ist, das eigene Volk zur Weltherrschaft zu bringen",
        capitalistPoints: [-1,-1,-1],
        conservativePoints: [30, 50, 75],
        extremistPoints: [10,5,0]),
    PoliticalQuestion(question: "Die Todesstrafe für Regimegegner muss erlaubt sein.",
        capitalistPoints: [-1,-1,-1],
        conservativePoints: [-1, -1, 30],
        extremistPoints: [35,20,0]),
    PoliticalQuestion(question: "Regimegegner werden des Landes verwiesen",
        capitalistPoints: [-1,-1,-1],
        conservativePoints: [-1, -1, -1],
        extremistPoints: [20,10,0]),
    PoliticalQuestion(question: "Arbeitsplätze schaffen ist wichtiger als der Schutz der Natur.",
        capitalistPoints: [80,0,20],
        conservativePoints: [-1, -1, -1],
        extremistPoints: [0,0,0]),
  ];



}