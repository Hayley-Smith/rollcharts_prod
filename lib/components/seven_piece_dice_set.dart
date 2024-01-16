import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'die.dart';

class SevenPieceDiceSet extends StatelessWidget {
  const SevenPieceDiceSet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Print to console if in debug mode
    if (kDebugMode) {
      print("Seven Piece Dice Set Built");
    }

    // List of dice to display on the home page
    final List<int> dice = [
      4,
      6,
      8,
      10,
      12,
      20,
      100,
    ];

    return Row(
      children: [
        Die(
          sides: dice[0],
        ),
        Die(
          sides: dice[1],
        ),
        Die(
          sides: dice[2],
        ),
        Die(
          sides: dice[3],
        ),
        Die(
          sides: dice[4],
        ),
        Die(
          sides: dice[5],
        ),
        Die(
          sides: dice[6],
        ),
      ],
    );
  }
}
