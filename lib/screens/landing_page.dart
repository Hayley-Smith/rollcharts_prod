import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import '../main.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Landing Page build method called");
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: const BoxDecoration(
                //borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                    image: AssetImage('assets/RCBanner.png'),
                    fit: BoxFit.fitWidth),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                  "RollCharts is a collection of random tables for tabletop RPG players and game masters. Search for a chart, tap for inspiration and tell your story.",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Responsive(),
                    ),
                  );
                },
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 34,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                  "This is a collection of random tables originally posted to /r/BehindTheTables and /r/DnDBehindTheScreen, compiled by OrkishBlade. Site design and development by Hayley Smith. ",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black26,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
