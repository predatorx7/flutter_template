import 'package:dio/dio.dart';
import 'package:example/src/services/uri.dart';
import 'package:example/src/utils/compute/json_decode.dart';

import 'package:flutter/foundation.dart';

export 'package:dio/dio.dart' show Dio;

class RepositoryError {
  final String message;
  final Object? error;
  final StackTrace? stackTrace;
  final String? errorMessage;

  const RepositoryError(
    this.message, {
    this.error,
    this.stackTrace,
    this.errorMessage,
  });

  @override
  String toString() {
    return 'RepositoryError($message)';
  }
}

abstract class HttpRepository {
  const HttpRepository();

  @protected
  AppApi get api;

  @protected
  String get baseUrl => api.url.toString();

  static bool decodeJsonInBackground = true;

  @protected
  Dio getHttpClient() {
    final headers = <String, dynamic>{};

    final options = BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
    );

    final _dio = Dio(options);

    if (decodeJsonInBackground) {
      setBackgroundJsonDecodingForDio(_dio.transformer);
    }

    return _dio;
  }
}

abstract class SingleServiceRepository<SERVICE> extends HttpRepository {
  SERVICE? _cachedService;

  @protected
  SERVICE createService(
    Dio dio, {
    required String baseUrl,
  });

  @protected
  SERVICE getService() {
    if (_cachedService == null) {
      final _dio = getHttpClient();

      _cachedService = createService(
        _dio,
        baseUrl: baseUrl,
      );
    }

    return _cachedService!;
  }
}

abstract class MultiServicesRepository extends HttpRepository {
  final Map<Type, Object> _cachedServices = {};

  void dispose() {
    _cachedServices.clear();
  }

  @protected
  List<Type> get supportedServices;

  @protected
  T createService<T extends Object>(
    Dio dio, {
    required String baseUrl,
  });

  @protected
  T getService<T extends Object>() {
    if (!supportedServices.contains(T)) {
      throw RepositoryError('Unsupported service: $T');
    }

    if (!_cachedServices.containsKey(T)) {
      final _dio = getHttpClient();

      _cachedServices[T] = createService<T>(
        _dio,
        baseUrl: baseUrl,
      );
    }

    return _cachedServices[T] as T;
  }
}
