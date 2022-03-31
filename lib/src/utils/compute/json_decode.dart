import 'dart:convert' show jsonDecode;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

void setBackgroundJsonDecodingForDio(Transformer transformer) {
  if (transformer is DefaultTransformer) {
    transformer.jsonDecodeCallback = parseJson;
  }
}
