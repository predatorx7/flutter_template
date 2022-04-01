import 'dart:convert' show json;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

dynamic _parseAndDecode(String response) {
  return json.decode(response);
}

dynamic parseJson(String text) {
  return compute(_parseAndDecode, text);
}

void setBackgroundDataProcessingForDio(Transformer transformer) {
  if (transformer is DefaultTransformer) {
    transformer.jsonDecodeCallback = parseJson;
  }
}
