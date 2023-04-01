import 'package:flutter/material.dart';
import 'package:super_heroes_landing/controllers/characters_controller.dart';
import '../configurations/colors.dart';
import '../models/results.dart';

class VerticalList extends StatefulWidget {
  const VerticalList({Key? key}) : super(key: key);

  @override
  State<VerticalList> createState() => _VerticalListState();
}

class _VerticalListState extends State<VerticalList> {
  final CharactersController _charactersController = CharactersController();
  final _scrollController = ScrollController();

  late final List<Results> _charactersList = [];

  bool _hasMoreCharacters = true;
  int _totalCharacters = 0;
  int _offset = 25;

  @override
  void initState() {
    super.initState();

    _charactersController.fetchCharacters().then((response) => {
          _charactersList.addAll(response.requestdata.results),
          _charactersList.removeRange(0, 5),
          _totalCharacters = response.requestdata.total
        });

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        if (_charactersList.length == _totalCharacters) {
          _hasMoreCharacters = false;
        }

        if (_charactersList.length <= _totalCharacters) {
          _charactersController
              .fetchCharacters(_offset)
              .then((response) => setState(() {
                    _charactersList.addAll(response.requestdata.results);
                    _offset += 25;
                  }));
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: _charactersList.length + 1,
        itemBuilder: (context, index) {
          if (index < _charactersList.length) {
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
                          "${_charactersList[index].thumbnail.path}.${_charactersList[index].thumbnail.extension}",
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
                                    _charactersList[index].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent),
                                  ),
                                ),
                                Text(
                                  "Quadrinhos: ${_charactersList[index].comics.available.toString()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Séries: ${_charactersList[index].series.available.toString()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Histórias: ${_charactersList[index].stories.available.toString()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Eventos: ${_charactersList[index].events.available.toString()}",
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
