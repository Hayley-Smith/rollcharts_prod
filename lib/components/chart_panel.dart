import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../models/chart.dart';
import '../models/roll.dart';
import '../screens/update_chart_page.dart';
import '../state/chart_provider.dart';
import '../state/roll_provider.dart';

class ChartPanel extends StatefulWidget {
  //Constructor
  const ChartPanel({
    super.key,
  });

  @override
  State<ChartPanel> createState() => _ChartPanelState();
}

class _ChartPanelState extends State<ChartPanel> {
  @override
  Widget build(BuildContext context) {
    // prints to the console when the build method is called
    if (kDebugMode) {
      print("Chart Panel Built");
    }

    // Gets the chart provider
    var width = MediaQuery.of(context).size.width;

    // Sets the number of columns based on the width of the screen
    var crossAxisCount = 8;

    // Sets the number of columns based on the width of the screen
    if (width < 600) {
      crossAxisCount = 4;
    } else if (width < 800) {
      crossAxisCount = 4;
    } else if (width < 1000) {
      crossAxisCount = 5;
    } else if (width < 1200) {
      crossAxisCount = 6;
    } else if (width < 1400) {
      crossAxisCount = 7;
    } else if (width < 1500) {
      crossAxisCount = 8;
    } else {
      crossAxisCount = 8;
    }
    if (kDebugMode) {
      print(width.toString());
    }

    // Serves a random item from the chart
    String serveRandomItemFromChart(Chart chart) {
      //creates a random number generator
      final random = Random();
      //gets a random position from the map. the nextInt method is exclusive
      //meaning it will never return the number 0
      final int randomPosition = random.nextInt(chart.listOfChartItems.length);
      //gets the item at the random position
      final randomItem = chart.listOfChartItems[randomPosition];
      //returns the random item as a string
      return randomItem;
    }

    // Builds a roll
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

    // Builds the chart panel
    return Consumer<ChartProvider>(
      builder: (context, provider, child) {
        // Builds a grid view of charts
        return GridView.builder(
          itemBuilder: (BuildContext context, int index) {
            // Gets the chart list from the provider
            final List<Chart> chartList = provider.getFilteredChartList;

            // Gets the chart at the index
            final Chart chart = chartList[index];

            // return a card with the chart name on it which will roll the chart on a tap
            return InkWell(
              onTap: () {
                String? item = serveRandomItemFromChart(chart);
                String rollName = chart.name;
                Roll roll = buildRoll(item!, rollName);
                addRoll(roll);
              },
              onLongPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateChartPage(chart: chart)),
                );
              },
              child: Card(
                elevation: 10,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      chart.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                    ),
                  ),
                ),
              ),
            );
          },

          // The number of items in the grid is the number of charts in the chart provider
          itemCount: provider.getFilteredChartList.length,

          // The grid will have 8 columns
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
          ),
        );
      },
    );
  }
}
