import 'package:flutter/material.dart';

import '../../models/results.dart';

class VerticalListText extends StatelessWidget {
  late Results character;

  VerticalListText({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.redAccent),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Quadrinhos: ${character.comics.available.toString()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  "Séries: ${character.series.available.toString()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  "Histórias: ${character.stories.available.toString()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  "Eventos: ${character.events.available.toString()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
