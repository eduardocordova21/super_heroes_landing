import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:super_heroes_landing/configurations/configuration.dart';
import '../configurations/endpoints.dart';
import '../models/response.dart';

class CharactersController {
  late Configuration _configuration;

  CharactersController() {
    _configuration = Configuration();
  }

  Future<Response> getCharacters([int offset = 0]) async {
    final apiResponse =
        await http.get(_configuration.getUri(Endpoint.characters.name, offset));

    var charactersResponse = Response.fromJson(jsonDecode(apiResponse.body));

    return charactersResponse;
  }
}
