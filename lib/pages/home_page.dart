import 'package:flutter/material.dart';
import 'package:super_heroes_landing/widgets/vertical_list_view.dart';

import '../models/results.dart';
import '../repository/character_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Super Hero Landing"),
        centerTitle: true,
      ),
      body: const VerticalListView(),
    );
  }
}
