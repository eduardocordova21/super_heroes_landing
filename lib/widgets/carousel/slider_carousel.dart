import 'package:flutter/material.dart';

import '../../configurations/colors.dart';
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
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            "${charactersList[index].thumbnail.path}.${charactersList[index].thumbnail.extension}",
            fit: BoxFit.fill,
          ),
          Positioned(
            height: MediaQuery.of(context).size.height / 10,
            right: 0,
            bottom: 0,
            child: Card(
              color: primaryBlack,
              child: Column(
                children: [
                  Flexible(
                    child: Text(
                      charactersList[index].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.redAccent),
                    ),
                  ),
                  Text(
                    "Quadrinhos: ${charactersList[index].comics.available.toString()} - Séries: ${charactersList[index].series.available.toString()}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    "Histórias: ${charactersList[index].stories.available.toString()} - Eventos: ${charactersList[index].events.available.toString()}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
