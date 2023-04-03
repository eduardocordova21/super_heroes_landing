import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:super_heroes_landing/configurations/configuration.dart';
import '../configurations/endpoints.dart';
import '../models/response.dart';

class ResponseController {
  late Configuration _configuration;

  ResponseController() {
    _configuration = Configuration();
  }

  Future<Response> fetchResponse([int offset = 0]) async {
    final apiResponse =
        await http.get(_configuration.getUri(Endpoint.characters.name, offset));

    var responseObject = Response.fromJson(jsonDecode(apiResponse.body));
    return responseObject;
  }
}
