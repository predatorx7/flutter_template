import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:magnific_core/magnific_core.dart';
import 'package:path/path.dart' as path;

import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:system_info2/system_info2.dart';

import '../disposable.dart';

Disposable $init() {
  switch (defaultTargetPlatform) {
    case TargetPlatform.windows:
      open.overrideFor(OperatingSystem.windows, _openOnWindows);
      break;
    case TargetPlatform.android:
      continue skip;
    case TargetPlatform.linux:
      open.overrideFor(OperatingSystem.linux, _openOnLinux);
      break;
    skip:
    default:
      return const Disposable();
  }

  logger.info('Script path: ${_scriptPath()}');

  final db = sqlite3.openInMemory();

  return Disposable(onDispose: db.dispose);
}

String _scriptPath() {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  return scriptDir.path;
}

DynamicLibrary _openOnWindows() {
  final scriptPath = _scriptPath();
  final libraryPath =
      '$scriptPath\\library\\windows\\x${SysInfo.userSpaceBitness}\\sqlite3.dll';
  final libraryNextToScript = path.canonicalize(libraryPath);
  logger.config('SQLITE3 Dynamic library: $libraryNextToScript');
  return DynamicLibrary.open(libraryNextToScript);
}

DynamicLibrary _openOnLinux() {
  final scriptPath = _scriptPath();
  final libraryPath = '$scriptPath/library/linux/sqlite3.so';
  final libraryNextToScript = path.canonicalize(libraryPath);
  logger.config('SQLITE3 Dynamic library: $libraryNextToScript');
  return DynamicLibrary.open(libraryNextToScript);
}
