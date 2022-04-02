// ignore_for_file: unused_element
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:drift/drift.dart';
import 'package:drift/remote.dart';
import 'package:flutter/foundation.dart';
import 'package:magnific_core/magnific_core.dart';

import '../account/db.dart';
import 'package:drift/web.dart';

// ISSUE: Always throws failed to fetch a service worker
DatabaseConnection _connectToWorker(String databaseName) {
  const workerPath =
      kReleaseMode ? 'dart_worker.dart.min.js' : 'dart_worker.dart.js';

  final worker = SharedWorker(
    workerPath,
    databaseName,
  );

  worker.onError.asBroadcastStream().listen((event) {
    logger.warning('worker error stream', event);
  });

  return remote(worker.port!.channel());
}

LazyDatabase _getDatabaseConnection(String databaseName) {
  return LazyDatabase(() async {
    final dbStorage = await DriftWebStorage.indexedDbIfSupported(databaseName);

    return WebDatabase.withStorage(dbStorage);
  });
}

UserAccountDatabase $userAccount(String databaseName) {
  final workerConnection = _getDatabaseConnection(databaseName);
  return UserAccountDatabase(workerConnection);
}
