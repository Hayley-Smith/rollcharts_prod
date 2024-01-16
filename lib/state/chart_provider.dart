
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/chart.dart';

class ChartProvider extends ChangeNotifier {
  ChartProvider() {
    // Call the fetchCharts method to populate the chartList from Firestore
    fetchCharts();
    if (kDebugMode) {
      print("ChartProvider constructor called - Charts fetched from DB");
    }
  }

  //create instance of firebase firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create collection reference for the charts
  final CollectionReference _chartsCollectionRef =
      FirebaseFirestore.instance.collection('charts');

  late List<Chart> chartList = [];

  late List<Chart> filteredChartList = [];

  get getFilteredChartList => filteredChartList;
  // get getChartList => chartList;

  Future<void> fetchCharts() async {
    try {
      final QuerySnapshot snapshot = await _chartsCollectionRef.get();
      List<Chart> charts = snapshot.docs.map((doc) {
        return Chart(
          name: doc["name"],
          listOfChartItems:
              (doc["listOfChartItems"] as List<dynamic>).cast<String>(),
          chartId: doc.id,
        );
      }).toList();
      if (kDebugMode) {
        print("${charts.length} charts fetched");
      }

      // Clear the existing chartList before adding new data
      filteredChartList.clear();
      chartList.clear();

      // sort charts alphabetically by name
      charts.sort((a, b) => a.name.compareTo(b.name));

      // Add the charts to the chartList
      filteredChartList.addAll(charts);
      chartList.addAll(charts);
      if (kDebugMode) {
        print("Charts added");
      }
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching charts: $e');
      }
    }
  }

  //  a function to add a chart to the list
  void addChart(Chart chart) {
    _firestore.collection("charts").add({
      'name': chart.name,
      'chartId': chart.chartId,
      'listOfChartItems': chart.listOfChartItems,
    });
    filteredChartList.add(chart);
    notifyListeners();
  }

  //  a function to remove a chart from the list
  void removeChart(Chart chart) {
    filteredChartList.remove(chart);

    //remove the chart from the database
    _firestore.collection("charts").doc(chart.chartId).delete();
    notifyListeners();
  }

  //  a function to update a chart in the list
  void updateChart(Chart chart) {
    //remove the old chart from the list
    filteredChartList
        .removeWhere((element) => element.chartId == chart.chartId);

    //add the updated chart to the list
    filteredChartList.add(chart);

    //update the chart in the database
    _firestore.collection("charts").doc(chart.chartId).update({
      'name': chart.name,
      'chartId': chart.chartId,
      'listOfChartItems': chart.listOfChartItems,
    });
    notifyListeners();
  }

  // a function to get a chart that name includes the search term
  List<Chart> getChartBySearchTermInName(String searchTerm) {
    return filteredChartList
        .where((element) => element.name.toLowerCase().contains(searchTerm))
        .toList();
    notifyListeners();
  }

  //  a function to clear the list of charts
  void clearChartList() {
    filteredChartList.clear();
    notifyListeners();
  }

  // filter charts where name contains value
  void filterCharts(String value) {
    List<Chart> filteredList = chartList
        .where((element) => element.name.toLowerCase().contains(value))
        .toList();
    filteredChartList = filteredList;
    notifyListeners();
  }
}
