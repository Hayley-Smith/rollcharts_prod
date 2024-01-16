import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/roll.dart';
import '../state/roll_provider.dart';

class RollPanel extends StatelessWidget {
  const RollPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Die Built");
    }

    //returns a consumer that builds a list of rolls
    return Consumer<RollProvider>(
      builder: (context, provider, child) {
        //gets the list of rolls from the provider
        final List<Roll> rolls = provider.rollList;

        //returns a list view builder that builds a list tile for each roll
        return ListView.builder(
          //sets the number of items in the list to the number of rolls
          itemCount: rolls.length,

          //builds a list tile for each roll
          itemBuilder: (BuildContext context, int index) {
            //formats the datetime to a displayable string
            var displayableString =
                rolls[index].createdAt.toString().substring(10, 16);

            //returns a list tile for each roll
            return Card(
              //color: Colors.transparent,
              child: ListTile(
                //displays the time the roll was created
                trailing: Text(displayableString),

                //displays the roll name and result
                title: Text(
                  "${rolls[index].rollName}: ${rolls[index].result}",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
