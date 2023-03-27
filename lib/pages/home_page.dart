import 'package:flutter/material.dart';

import '../models/results.dart';
import '../repository/character_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Results> charactersList = [];
  final scrollController = ScrollController();
  bool hasMoreCharacters = true;
  int totalCharacters = 0;
  int offset = 25;

  @override
  void initState() {
    super.initState();

    CharacterRepository().fetchCharacters().then((response) => {
          charactersList.addAll(response.requestdata.results),
          totalCharacters = response.requestdata.total
        });

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (charactersList.length == totalCharacters) {
          hasMoreCharacters = false;
        }

        if (charactersList.length < totalCharacters) {
          CharacterRepository()
              .fetchCharacters(offset)
              .then((response) => setState(() {
                    charactersList.addAll(response.requestdata.results);
                    offset += 25;
                  }));
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Super Hero Landing",
          style: TextStyle(fontFamily: "Quantico"),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          controller: scrollController,
          itemCount: charactersList.length + 1,
          itemBuilder: (context, index) {
            if (index < charactersList.length) {
              return Center(
                child: Column(
                  children: [
                    Text(
                      index.toString(),
                      style: const TextStyle(
                        fontFamily: "Quantico",
                      ),
                    ),
                    Text(
                      charactersList[index].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: "Quantico"),
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: hasMoreCharacters
                      ? const CircularProgressIndicator()
                      : const Text("Sem mais dados para carregar"),
                ),
              );
            }
          }),
    );
  }
}
