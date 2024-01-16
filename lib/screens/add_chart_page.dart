import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/chart.dart';
import '../state/chart_provider.dart';

class AddChartPage extends StatefulWidget {
  const AddChartPage({Key? key}) : super(key: key);

  @override
  State<AddChartPage> createState() => _AddChartPageState();
}

class _AddChartPageState extends State<AddChartPage> {
  String chartTitle = 'Enter a chart title above. Be descriptive but concise.';
  List<String> chartData = [];

  buildChart() {
    Chart chart = Chart(
      chartId: Random().nextInt(100000).toString(),
      name: chartTitle,
      listOfChartItems: chartData,
    );
    return chart;
  }

  saveChart() {
    Chart chart = buildChart();
    Provider.of<ChartProvider>(context, listen: false).addChart(chart);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Build the app bar
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              saveChart();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.save,
            ),
          ),
        ],
        title: const Text(
          'Add Chart',
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
                              print(value);
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
                    trailing: const Icon(Icons.delete),
                    onTap: () {
                      setState(() {
                        chartData.removeAt(index);
                      });
                    },
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
