import 'package:flutter/material.dart';
import 'package:super_heroes_landing/controllers/characters_controller.dart';
import 'package:super_heroes_landing/widgets/carousel/carousel.dart';
import 'package:super_heroes_landing/widgets/my_exception.dart';
import 'package:super_heroes_landing/widgets/vertical_list/vertical_list.dart';

import '../models/response.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CharactersController _responseController = CharactersController();

  late Future<Response> _apiResponse;

  @override
  void initState() {
    super.initState();
    _apiResponse = _responseController.getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Super Hero Landing"),
        centerTitle: true,
      ),
      body: FutureBuilder<Response>(
        future: _apiResponse,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Carousel(
                    charactersList: snapshot.data!.requestdata.results
                        .getRange(0, 5)
                        .toList()),
                Expanded(
                  child: VerticalList(
                      charactersList: snapshot.data!.requestdata.results,
                      totalCharacters: snapshot.data!.requestdata.total),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return MyException(
                snapshot: snapshot, contextWidgetToReload: context);
          }

          return Container(
            alignment: AlignmentDirectional.center,
            child:
                const CircularProgressIndicator(key: Key("circularProgress")),
          );
        },
      ),
    );
  }
}
