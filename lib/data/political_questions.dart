import 'dart:core';

import 'package:flutter/material.dart';
import 'package:politics_game/objects/political_question.dart';

class PoliticalQuestions {
  List<PoliticalQuestion> get questions => [
    PoliticalQuestion(
        question: "Ein reiches Land muss Entwicklungshilfe an bedürftige Staaten leisten.",
        politicalPoints: [-5, 0, 8],
        extremistPoints: [0, 0, 0]),
    PoliticalQuestion(
        question: "Wir müssen Einwanderung zulassen und bedürftigen Menschen Asyl bieten.",
        politicalPoints: [-5, 0, 5],
        extremistPoints: [0, 0, 0]),
    PoliticalQuestion(question: "Marihuana muss legalisiert werden",
        politicalPoints: [-3, 0, 3],
        extremistPoints: [0, 0, 0]),
    PoliticalQuestion(
        question: "Der Staat muss Geld von reichen Menschen zu armen Menschen umverteilen",
        politicalPoints: [-8,0,4],
        extremistPoints: [0,0,0]),
    PoliticalQuestion(question: "Der Staat soll in den Markt eingreifen",
        politicalPoints: [-3,0,3],
        extremistPoints: [0,0,0]),
    PoliticalQuestion(question: "Kulturelle Minderheiten dürfen weniger Rechte haben",
        politicalPoints: [8,7,-3],
        extremistPoints: [10,5,0]),
    PoliticalQuestion(question: "Es muss ein Maximalgehalt von Löhnen in einem Vorstand geben",
        politicalPoints: [4,0,-2],
        extremistPoints: [0,0,0]),
    PoliticalQuestion(question: "Allen Menschen muss eine kostenlose Gesundheitsversorgung zustehen",
        politicalPoints: [4,0,-4],
        extremistPoints: [0,0,0]),
    PoliticalQuestion(question: "Unser Staat hat natürliche Feinde.",
        politicalPoints: [8,3,-3],
        extremistPoints: [10,0,0]),
    PoliticalQuestion(question: "Der gewählte Staatsoberhaupt darf andere Meinungen unterdrücken",
        politicalPoints: [0,0,0],
        extremistPoints: [10,0,0]),
    PoliticalQuestion(question: "Das oberste Ziel eines Präsidenten ist, das eigene Volk zur Weltherrschaft zu bringen",
        politicalPoints: [8,3,-3],
        extremistPoints: [10,0,0]),
    PoliticalQuestion(question: "Die Todesstrafe für Regimegegner muss erlaubt sein.",
        politicalPoints: [0,0,0],
        extremistPoints: [10,0,0]),
    PoliticalQuestion(question: "Regimegegner werden des Landes verwiesen",
        politicalPoints: [0,0,0],
        extremistPoints: [10,0,0]),
    PoliticalQuestion(question: "Arbeitsplätze schaffen ist wichtiger als der Schutz der Natur.",
        politicalPoints: [5,0,-5],
        extremistPoints: [0,0,0]),
  ];



}