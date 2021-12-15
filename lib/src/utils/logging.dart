import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:magnific_core/magnific_core.dart';

FlutterLoggingManager createDefaultLoggingManager() {
  return FirebaseFlutterLoggingManager(
    level: kDebugMode ? Level.ALL : Level.WARNING,
    tree: kIsWeb || kDebugMode
        ? PrintingColoredLogsTree()
        : FirebaseLogsTree(
            crashlytics: FirebaseCrashlytics.instance,
          ),
  );
}

class FirebaseFlutterLoggingManager extends FlutterLoggingManager {
  FirebaseFlutterLoggingManager({
    String loggerName = 'LoggingManager',
    Level? level = Level.ALL,
    LoggingTree? tree,
  }) : super(
          loggerName: loggerName,
          level: level,
          tree: tree,
        );

  @override
  Future<void> onFlutterError(FlutterErrorDetails details) {
    return FirebaseCrashlytics.instance.recordFlutterError(details);
  }
}

class FirebaseLogsTree extends FormattedOutputLogsTree {
  /// Value of [level.value] >= this will allow print of stacktrace
  final int errorThreshold;
  final FirebaseCrashlytics crashlytics;

  FirebaseLogsTree({
    this.errorThreshold = 900,
    required this.crashlytics,
  });

  @override
  void logger(
    String messageText,
    String objectText,
    FormattedStackTrace stacktrace,
    LogRecord record,
    LogLineInfo info,
  ) {
    StackTrace? stackTrace;
    final reason = '$messageText$objectText';
    if (record.level.value > errorThreshold) {
      stackTrace = stacktrace.stackTrace;
      crashlytics.recordError(
        record.error,
        stackTrace,
        reason: reason,
        printDetails: true,
      );
    } else {
      crashlytics.log(reason);
    }
  }
}
