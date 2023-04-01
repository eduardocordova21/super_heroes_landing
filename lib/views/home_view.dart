import 'package:flutter/material.dart';
import 'package:super_heroes_landing/widgets/carousel/carousel.dart';
import 'package:super_heroes_landing/widgets/vertical_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Super Hero Landing"),
        centerTitle: true,
      ),
      body: Column(
        children: const [
          Carousel(),
          Expanded(
            child: VerticalList(),
          ),
        ],
      ),
    );
  }
}
