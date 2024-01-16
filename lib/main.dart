import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:rollcharts_prod/screens/desktop_layout.dart';
import 'package:rollcharts_prod/screens/landing_page.dart';
import 'package:rollcharts_prod/screens/phone_layout.dart';
import 'package:rollcharts_prod/screens/tablet_layout.dart';
import 'package:rollcharts_prod/state/chart_provider.dart';
import 'package:rollcharts_prod/state/roll_provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // Constructor
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Return a multi provider with the roll provider and the chart provider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => RollProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ChartProvider(),
        ),
      ],
      // Return a material app
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RollCharts',

        // Theme the app
        theme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color.fromRGBO(172, 205, 181, 100),
            onPrimary: Colors.black,
            secondary: Color.fromRGBO(172, 205, 181, 100),
            onSecondary: Colors.black,
            error: Colors.red,
            onError: Colors.black,
            background: Color.fromRGBO(172, 205, 181, 100),
            onBackground: Colors.black,
            surface: Color.fromRGBO(172, 205, 181, 100),
            onSurface: Colors.black,
          ),
          useMaterial3: true,
        ),

        // Home page
        home: LandingPage(),
      ),
    );
  }
}

class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        // If the screen is small, return the phone layout
        if (sizingInformation.isMobile) {
          return const PhoneLayout();
        }
        // If the screen is medium, return the desktop layout with a shrinking header
        else if (sizingInformation.isTablet) {
          return const TabletLayout();
        }
        // If the screen is large, return the desktop layout
        else {
          return const DesktopLayout(title: "RollCharts");
        }
      },
    );
  }
}
