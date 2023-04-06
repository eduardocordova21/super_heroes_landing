import 'package:flutter/material.dart';

import '../configurations/colors.dart';
import '../models/results.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context)!.settings.arguments as Results;

    return Scaffold(
      backgroundColor: primaryBlack,
      appBar: AppBar(
        title: Text(character.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: Image.network(
                  "${character.thumbnail.path}.${character.thumbnail.extension}",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                character.description,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                softWrap: true,
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
