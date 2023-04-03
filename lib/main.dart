import 'package:flutter/material.dart';
import 'package:super_heroes_landing/views/home_view.dart';

import 'configurations/colors.dart';
import 'configurations/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Quantico",
        primarySwatch: primaryBlack,
      ),
      initialRoute: NavigationRoute.home.name,
      routes: {
        NavigationRoute.home.name: (context) => const HomeView(),
      },
    );
  }
}
