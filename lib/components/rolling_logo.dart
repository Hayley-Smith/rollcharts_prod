import 'package:flutter/material.dart';

class RollingLogoPage extends StatefulWidget {
  const RollingLogoPage({Key? key}) : super(key: key);

  @override
  State<RollingLogoPage> createState() => _RollingLogoPageState();
}

class _RollingLogoPageState extends State<RollingLogoPage> {
  //define height and width of logo
  double width = 500;
  double height = 500;
  BorderRadiusGeometry borderRadius = BorderRadius.circular(8);

  double turns = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: AnimatedRotation(
            curve: Curves.easeInToLinear,
            turns: turns,
            duration: const Duration(seconds: 4),
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                image: const DecorationImage(
                  image: AssetImage('assets/logogreenbackground.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // When the user taps the button
          onPressed: () {
            // Use setState to rebuild the widget with new values.
            setState(() {
              turns += 2;
            });
          },
          child: const Icon(Icons.play_arrow),
        ));
  }
}
