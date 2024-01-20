import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../components/chart_panel.dart';
import '../components/roll_panel.dart';
import '../components/rolling_logo.dart';
import '../components/seven_piece_dice_set.dart';
import '../state/chart_provider.dart';


class DesktopLayout extends StatefulWidget {
  // Constructor
  const DesktopLayout({super.key, required this.title});

  // Title of the home page
  final String title;

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  var searchBarType = 'Start typing to search...';

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Desktop Layout build method called");
    }

    // Build the home page
    return Scaffold(
      // Build the app bar
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),

      // Build the body
      body: Stack(
        children: [
          //background image
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              //borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: AssetImage('assets/rcdesktop.png'),
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
                                onSubmitted: (value) {
                                  provider.filterCharts(value);
                                  if (kDebugMode) {
                                    print(value);
                                  }
                                  setState(() {});
                                },
                                onChanged: (value) {
                                  provider.filterCharts(value);
                                  if (kDebugMode) {
                                    print(value);
                                  }
                                  setState(() {});
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
                        flex: 4,
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
