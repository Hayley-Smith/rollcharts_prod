import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/chart.dart';
import '../state/chart_provider.dart';

class UpdateChartPage extends StatefulWidget {
  final Chart chart;
  const UpdateChartPage({Key? key, required this.chart}) : super(key: key);

  @override
  State<UpdateChartPage> createState() => _UpdateChartPageState();
}

class _UpdateChartPageState extends State<UpdateChartPage> {
  @override
  Widget build(BuildContext context) {
    String chartTitle = widget.chart.name;
    List<String> chartData = widget.chart.listOfChartItems;

    buildChart() {
      Chart chart = Chart(
        chartId: Random().nextInt(100000).toString(),
        name: chartTitle,
        listOfChartItems: chartData,
      );
      return chart;
    }

    //update chart
    updateChart() {
      Chart chart = buildChart();
      Provider.of<ChartProvider>(context, listen: false).updateChart(chart);
    }

    return Scaffold(
      // Build the app bar
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              updateChart();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.save,
            ),
          ),
        ],
        title: const Text(
          'Update Chart',
        ),
      ),

      // Build the body
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * .1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<ChartProvider>(
                      builder: (context, provider, child) {
                        return TextField(
                          onChanged: (value) {
                            setState(() {
                              chartTitle = value;
                            });
                          },
                          decoration: const InputDecoration(
                            // border: InputBorder.none,
                            hintText: "Enter a title",
                            hintStyle: TextStyle(
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
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<ChartProvider>(
                      builder: (context, provider, child) {
                        var chartItemController = TextEditingController();
                        return TextField(
                          controller: chartItemController,
                          onSubmitted: (value) {
                            setState(() {
                              chartData.add(value);
                              if (kDebugMode) {
                                print(value);
                              }
                              chartItemController.clear();
                            });
                            //return cursor to text field
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          decoration: const InputDecoration(
                            // border: InputBorder.none,
                            hintText: "Enter a chart item",
                            hintStyle: TextStyle(
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
          const SizedBox(
            height: 20,
          ),
          Text(chartTitle),
          Expanded(
            child: ListView.builder(
              itemCount: chartData.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.drag_handle),
                    trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            chartData.removeAt(index);
                          });
                        }),
                    title: Text(chartData[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
