import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:flutter/material.dart';

class Configuration {
  final String _apiDomain = "gateway.marvel.com";
  final String _apiPath = "/v1/public/";
  final String _apiPublicKey = "d9ff47c89309b9aa0934ab35b947b2b0";
  final String _apiPrivateKey = "f76f4858d12420cf263450d45bd799dc08048e41";

  late int _timestamp;

  Configuration() {
    _timestamp = DateTime.now().millisecondsSinceEpoch;
  }

  String _getHash() {
    var stringFromHash = "$_timestamp$_apiPrivateKey$_apiPublicKey";
    var hash = md5.convert(utf8.encode(stringFromHash)).toString();
    return hash;
  }

  Map<String, dynamic> _getQueryParameters(int offset) {
    final params = {
      "ts": _timestamp.toString(),
      "apikey": _apiPublicKey,
      "hash": _getHash(),
      "limit": 25.toString(),
      "offset": offset.toString(),
    };

    return params;
  }

  Uri getUri(String endpoint, [int offset = 0]) {
    return Uri.https(_apiDomain, _apiPath + endpoint, _getQueryParameters(offset));
  }
}
