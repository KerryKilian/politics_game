import 'package:flutter/material.dart';

/**
 * Ermittle aus den Participants, wie viele Personen es sind und welche politische Ausrichtung es hat
 */
class Demonstration {
  late DateTime _started;
  late String title;
  late String description;
  late List<String> _participants;
  late double _politicalOrientation;
  late double _politicalExtremism;

  Demonstration({required this.title, required this.description}) {
    this._started = DateTime.now();
    _participants = [];
  }

  void addParticipant(String uid) {
    _participants.add(uid);
  }

  void removeParticipant(String uid) {
    _participants.removeAt(_participants.indexOf(uid));
  }

  int get length {
    return _participants.length;
  }

  double get politicalOrientation {
    double orientation = 0;
    _participants.forEach((uid) {
      // get political orientation from uid
    });
    return orientation;
  }

  double get politicalExtremism {
    double orientation = 0;
    _participants.forEach((uid) {
      // get political extremism from uid
    });
    return orientation;
  }

  DateTime get started {
    return _started;
  }

}
