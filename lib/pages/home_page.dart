import 'package:flutter/material.dart';

import '../models/response.dart';
import '../repository/character_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Response> response;

  @override
  void initState() {
    super.initState();
    response = CharacterRepository().fetchCharacters();
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
      body: FutureBuilder<Response>(
          future: response,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.requestdata?.count,
                  itemBuilder: (context, index) {
                    return Text(
                      snapshot.data!.requestdata.results[index].name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: "Quantico"),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          }),
    );
  }
}
