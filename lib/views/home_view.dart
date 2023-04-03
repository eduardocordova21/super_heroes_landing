import 'package:flutter/material.dart';
import 'package:super_heroes_landing/controllers/response_controller.dart';
import 'package:super_heroes_landing/widgets/carousel/carousel.dart';
import 'package:super_heroes_landing/widgets/vertical_list.dart';

import '../models/response.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ResponseController _responseController = ResponseController();

  late Future<Response> _apiResponse;

  @override
  void initState() {
    super.initState();
    _apiResponse = _responseController.fetchResponse();
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
                Carousel(charactersList: snapshot.data!.requestdata.results.getRange(0, 5).toList()),
                Expanded(
                  child: VerticalList(
                      charactersList: snapshot.data!.requestdata.results,
                      totalCharacters:
                          snapshot.data!.requestdata.results.length),
                ),
              ],
            );
          }

          if (snapshot.hasError) {
            AlertDialog(
              title: const Text("Problema encontrado"),
              content: Text(snapshot.error.toString()),
            );
          }

          return Container(
            alignment: AlignmentDirectional.center,
            child: const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
