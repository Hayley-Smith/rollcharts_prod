import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../components/chart_panel.dart';
import '../components/roll_panel.dart';
import '../components/seven_piece_dice_set.dart';
import '../models/chart.dart';
import '../state/chart_provider.dart';

class PhoneLayout extends StatefulWidget {
  const PhoneLayout({Key? key}) : super(key: key);

  @override
  State<PhoneLayout> createState() => _PhoneLayoutState();
}

class _PhoneLayoutState extends State<PhoneLayout> {
  var searchBarType = 'Filter charts...';
  late Chart selectedChart;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("PhoneLayout build method called");
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("RollCharts"),
        actions: [],
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
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: const Icon(Icons.filter_alt_rounded),
                          onPressed: () {
                            setState(() {
                              searchBarType = 'Filter charts...';
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
                                    print(
                                        "Text field changed - phone layout - $value");
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

              // Roll Panel

              // Chart Panel

              // Roll Panel
              const Expanded(
                flex: 2,
                child: RollPanel(),
              ),
              const Expanded(
                flex: 4,
                child: ChartPanel(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
