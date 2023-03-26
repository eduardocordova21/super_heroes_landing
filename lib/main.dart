import 'package:flutter/material.dart';
import 'package:super_heroes_landing/pages/home_page.dart';

import 'configurations/colors.dart';

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
        primarySwatch: primaryBlack,
      ),
      home: const HomePage(),
    );
  }
}