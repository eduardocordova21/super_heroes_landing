import 'package:flutter/material.dart';

import '../../models/results.dart';

class SliderCarousel extends StatelessWidget {
  List<Results> charactersList = [];
  bool active = false;
  int index = 0;

  SliderCarousel(
      {Key? key,
      required this.charactersList,
      required this.index,
      required this.active})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double margin = active ? 10 : 20;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "${charactersList[index].thumbnail.path}.${charactersList[index].thumbnail.extension}"),
              fit: BoxFit.fill)),
    );
  }
}
