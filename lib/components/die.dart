import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/roll.dart';
import '../state/roll_provider.dart';

class Die extends StatelessWidget {
  final int sides;

  const Die({
    super.key,
    required this.sides,
  });

  @override
  Widget build(BuildContext context) {
    // Serve a random number between 1 and the number of sides
    String serveRandomNumber() {
      final int randomNumber = Random().nextInt(sides) + 1;
      return randomNumber.toString();
    }

    // Serve a random number between 1 and the number of sides with a bell curve
    String serveRandomNumberWithBellCurve() {
      // Get the number of sides halved
      int sidesHalved = sides ~/ 2;

      //  Get two random numbers between 1 and the number of sides halved
      int randomNumber = Random().nextInt(sidesHalved) + 1;
      int randomNumber2 = Random().nextInt(sidesHalved) + 1;
      int randomNumber3 = randomNumber + randomNumber2;

      //  Return the random number as a string
      return randomNumber3.toString();
    }

    // Build a roll
    Roll buildRoll(String item, String rollName) {
      return Roll(
        rollId: DateTime.now().toString(),
        rollName: rollName,
        result: item,
      );
    }

    // Add a roll to the roll provider
    void addRoll(Roll roll) {
      Provider.of<RollProvider>(context, listen: false).addRoll(roll);
    }

    // Convert the number of sides to a string
    final String numberOfSides = sides.toString();

    // Return a card with the number of sides on it which will roll the die
    // on a tap and on a double tap will roll the die with a bell curve
    return SizedBox(
      width: MediaQuery.of(context).size.width / 7,
      child: InkWell(
        onDoubleTap: () {
          String randomNumber = serveRandomNumberWithBellCurve();
          Roll roll = buildRoll(randomNumber, "D$numberOfSides - Bell Curve");
          addRoll(roll);
        },
        onTap: () {
          String randomNumber = serveRandomNumber();
          Roll roll = buildRoll(randomNumber, "D$numberOfSides");
          addRoll(roll);
        },
        child: Card(
          color: Colors.transparent,
          child: Center(
            child: Text("D$numberOfSides",
                style: TextStyle(
                  color: Colors.white60,
                  // fontSize: 26,
                )),
          ),
        ),
      ),
    );
  }
}
