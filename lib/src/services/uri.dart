// import 'package:app_boot/app_boot.dart' show currentSettings;

String trimLeft(String from, String pattern) {
  if (from.isEmpty || pattern.isEmpty || pattern.length > from.length) {
    return from;
  }

  String _form = from;

  while (_form.startsWith(pattern)) {
    _form = _form.substring(pattern.length);
  }

  return _form;
}

String trimRight(String from, String pattern) {
  if (from.isEmpty || pattern.isEmpty || pattern.length > from.length) {
    return from;
  }

  String _from = from;

  while (_from.endsWith(pattern)) {
    _from = _from.substring(0, from.length - pattern.length);
  }
  return _from;
}

String trim(String from, String pattern) {
  return trimLeft(trimRight(from, pattern), pattern);
}

class AppApi {
  final Uri backendUri;

  const AppApi(this.backendUri);

  /// Returns the base URL as String for the API.
  /// For consistency, this should be used instead of the individual APIs.
  Uri get url {
    return backendUri;
  }

  /// Returns the base URL as String for the API.
  /// For consistency, this should be used instead of the individual APIs.
  ///
  /// The string returned by this method always ends with `/`.
  String urlString() {
    final _u = url.toString();

    if (_u.endsWith('/')) {
      return _u;
    } else {
      return '$_u/';
    }
  }

  Iterable<String> _createPathSegments(String path) {
    final _path = trim(path, '/');
    return _path.isEmpty ? [] : _path.split('/');
  }

  /// Returns a [Uri] where [path] segment is added to the base [url].
  Uri join(String path) {
    final _url = url;

    final _path = _url.pathSegments.map((e) => e).toList();

    if (path.isNotEmpty) {
      _path.addAll(_createPathSegments(path));
    }

    return Uri(
      scheme: _url.scheme,
      userInfo: _url.userInfo,
      host: _url.host,
      port: _url.port,
      pathSegments: _path,
    );
  }
}
