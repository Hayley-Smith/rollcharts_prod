import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../components/chart_panel.dart';
import '../components/roll_panel.dart';
import '../components/seven_piece_dice_set.dart';
import '../state/chart_provider.dart';

class TabletLayout extends StatefulWidget {
  const TabletLayout({Key? key}) : super(key: key);

  @override
  State<TabletLayout> createState() => _TabletLayoutState();
}

class _TabletLayoutState extends State<TabletLayout> {
  var searchBarType = 'Filter charts...';
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Tablet Layout build method called");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("RollCharts"),
      ),
      body: Stack(
        children: [
          //background image
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              //borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: AssetImage('assets/farmland.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Build the main column
          Column(
            children: [
              // Build the dice row
              const Expanded(
                flex: 1,
                child: SevenPieceDiceSet(),
              ),

              // Filter charts row
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Card(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: IconButton(
                    //       icon: const Icon(Icons.note_add_outlined),
                    //       onPressed: () {
                    //         setState(() {
                    //           searchBarType = 'Take a note';
                    //         });
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // SaveToPDF(),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: const Icon(Icons.filter_alt_rounded),
                          onPressed: () {
                            setState(() {
                              searchBarType = 'Filter Charts';
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Consumer<ChartProvider>(
                            builder: (context, provider, child) {
                              return TextField(
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                onChanged: (value) {
                                  // TODO: Filter the list based on user input
                                  provider.filterCharts(value);
                                  setState(() {
                                    print(value);
                                  });
                                },
                                decoration: InputDecoration(
                                  // border: InputBorder.none,
                                  hintText: searchBarType,
                                  hintStyle: const TextStyle(
                                    color: Colors.white60,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Build the roll panel and chart panel
              Expanded(
                flex: 7,
                child: SizedBox(
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: RollPanel(),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Expanded(
                              child: Consumer<ChartProvider>(
                                builder: (context, provider, child) {
                                  return const ChartPanel();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
