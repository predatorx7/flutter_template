import 'dart:io';
import 'dart:isolate';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:magnific_core/magnific_core.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as pp;

class DatabaseConnectionProvider {
  final String databaseFileName;

  const DatabaseConnectionProvider(this.databaseFileName);

  /// This can only be used on main isolate as it uses [MethodChannel]s from `path_provider` package.
  ///
  /// Since we can't use getApplicationDocumentsDirectory on a background isolate, we should calculate
  /// the database path in the foreground isolate and then inform the
  /// background isolate about the path.
  ///
  /// ! Only for main isolates
  Future<String> get databaseFilePath async {
    final applicationSupport = await pp.getApplicationSupportDirectory();
    final databasePath = p.join(applicationSupport.path, 'database');
    final dbFolder = Directory(databasePath);
    if (!await dbFolder.exists()) {
      await dbFolder.create(recursive: true);
    }
    final savePath = p.join(dbFolder.path, databaseFileName);
    logger.config('Databse save path: $savePath');
    return savePath;
  }

  LazyDatabase get fromForeground {
    // the LazyDatabase util lets us find the right location for the file async.
    return LazyDatabase(_fromForeground);
  }

  Future<QueryExecutor> _fromForeground() async {
    final path = await databaseFilePath;
    final file = File(path);
    return NativeDatabase(file);
  }

  /// Opens a database connection in background isolate and returns to main isolate.
  ///
  /// ! Only for main isolates
  DatabaseConnection get fromBackground {
    return DatabaseConnection.delayed(_fromBackground());
  }

  Future<DatabaseConnection> _fromBackground() async {
    final path = await databaseFilePath;
    final isolate = await _BackgroundConnectionProvider._createDriftIsolate(
      path,
    );
    return await isolate.connect();
  }

  static void shareDriftIsolate(DriftIsolate isolate, SendPort sendPort) {
    sendPort.send(isolate.connectPort);
  }
}

class _BackgroundConnectionProvider {
  _BackgroundConnectionProvider._();

  /// ! Only for main isolates
  static Future<DriftIsolate> _createDriftIsolate(String databasePath) async {
    final receivePort = ReceivePort();

    await Isolate.spawn(
      _startBackground,
      _IsolateStartRequest(receivePort.sendPort, databasePath),
    );

    // _startBackground will send the DriftIsolate to this ReceivePort
    return await receivePort.first as DriftIsolate;
  }

  /// ! Only for background isolate
  static void _startBackground(_IsolateStartRequest request) {
    // this is the entry point from the background isolate! Let's create
    // the database from the path we received
    final executor = NativeDatabase(File(request.targetPath));
    // we're using DriftIsolate.inCurrent here as this method already runs on a
    // background isolate. If we used DriftIsolate.spawn, a third isolate would be
    // started which is not what we want!
    final driftIsolate = DriftIsolate.inCurrent(
      () => DatabaseConnection.fromExecutor(executor),
    );
    // inform the starting isolate about this, so that it can call .connect()
    request.sendDriftIsolate.send(driftIsolate);
  }
}

// used to bundle the SendPort and the target path, since isolate entry point
// functions can only take one parameter.
class _IsolateStartRequest {
  final SendPort sendDriftIsolate;
  final String targetPath;

  const _IsolateStartRequest(this.sendDriftIsolate, this.targetPath);
}
