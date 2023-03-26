import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:super_heroes_landing/configurations/configuration.dart';
import '../models/character.dart';

class CharacterRepository {
  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse("${Configuration.getApiUrl()}/v1/public/characters"));

    if (response.statusCode == 200) {
      List<dynamic> objectsList = jsonDecode(response.body);
      List<Character> charactersList = [];

      for (var character in objectsList) {
        charactersList.add(Character.fromJson(character));
      }

      return charactersList;
    } else {
      throw Exception("RUN BITCH, RUUUUUUN!");
    }
  }
}
