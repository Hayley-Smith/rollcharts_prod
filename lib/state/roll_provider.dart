import 'package:flutter/material.dart';

import '../models/roll.dart';

class RollProvider extends ChangeNotifier {
  // List of rolls
  final List<Roll> rollList = [
    Roll(
      rollId: "1",
      result: "🎸",
      rollName: "Your rolls will appear here",
    ),
    // Roll(
    //   rollId: "2",
    //   result: "2",
    //   rollName: "D6",
    // ),
  ];

  // Get the list of rolls
  get getRollList => rollList;

  // Add a roll to the roll list
  void addRoll(Roll roll) {
    rollList.insert(0, roll);
    notifyListeners();
  }

  // Remove a roll from the roll list
  void removeRoll(Roll roll) {
    rollList.remove(roll);
    notifyListeners();
  }

  // Clear the roll list
  void clearRollList() {
    rollList.clear();
    notifyListeners();
  }
}
