import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:super_heroes_landing/configurations/configuration.dart';
import 'package:super_heroes_landing/models/results.dart';
import '../configurations/endpoints.dart';
import '../models/response.dart';

class CharacterRepository {

  late Configuration _configuration;

  CharacterRepository(){
    _configuration =  Configuration();
  }

  Future<Response> fetchCharacters([int offset = 0]) async {
    final apiResponse = await http.get(_configuration.getUri(Endpoint.characters.name, offset));

    if (apiResponse.statusCode == 200) {
      var responseObject = Response.fromJson(jsonDecode(apiResponse.body));
      return responseObject;
    } else {
      throw Exception("RUN BITCH, RUUUUUUN!");
    }
  }
}
