import 'package:flutter/material.dart';

import '../models/results.dart';
import '../repository/character_repository.dart';

class VerticalListView extends StatefulWidget {
  const VerticalListView({Key? key}) : super(key: key);

  @override
  State<VerticalListView> createState() => _VerticalListViewState();
}

class _VerticalListViewState extends State<VerticalListView> {
  final scrollController = ScrollController();

  late List<Results> charactersList = [];
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

        if (charactersList.length <= totalCharacters) {
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
    return ListView.builder(
        controller: scrollController,
        itemCount: charactersList.length + 1,
        itemBuilder: (context, index) {
          if (index < charactersList.length) {
            return Center(
              child: Column(
                children: [
                  Text(index.toString()),
                  Text(
                    charactersList[index].name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
