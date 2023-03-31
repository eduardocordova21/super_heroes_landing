import 'package:flutter/material.dart';

import '../../configurations/colors.dart';
import '../../models/results.dart';
import '../../repository/character_repository.dart';

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
            return Card(
              elevation: 40,
              margin: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: primaryBlack,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.network(
                          "${charactersList[index].thumbnail.path}.${charactersList[index].thumbnail.extension}",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    charactersList[index].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent),
                                  ),
                                ),
                                Text(
                                  "Quadrinhos: ${charactersList[index].comics.available.toString()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Séries: ${charactersList[index].series.available.toString()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Histórias: ${charactersList[index].stories.available.toString()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Eventos: ${charactersList[index].events.available.toString()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          )),
                    ],
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
