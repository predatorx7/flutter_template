import 'package:cached_network_image/cached_network_image.dart';
import 'package:example/build_options.dart';
import 'package:example/src/utils/sql/disposable.dart';
import 'package:example/src/utils/sql/initialize.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:magnific_core/magnific_core.dart';

import '../../firebase_options.dart';

Future<void> onStart() async {
  buildConfigurations.assertDevelopmentFlags();
  await _initFirebase();
}

Disposable? _platformDatabaseDisposable;

List<Future> onStarted() {
  _platformDatabaseDisposable = initializePlatformDatabase();

  cachedNetworkImageProviver = (it) => CachedNetworkImageProvider(it);
  return <Future>[
    _addFontLicense(),
  ];
}

Future<void> onEnd() {
  if (_platformDatabaseDisposable != null) {
    _platformDatabaseDisposable!.dispose();
  }
  return Future.value(null);
}

Future<void> _addFontLicense() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}

Future<void> _initFirebase() async {
  if (!packageSupportInfo.isFirebaseSupported) return;

  await Firebase.initializeApp(
    // TODO: Use this till we get a way to add configs of multiple flavors for android & iOS
    options: packageSupportInfo.isFirebaseDartConfigAvailable
        ? DefaultFirebaseOptions.currentPlatform
        : null,
  );

  // Force disable Crashlytics collection while doing every day development.
  // Temporarily toggle this to true if you want to test crash reporting in your app.
  if (!kIsWeb && kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }

  if (!kDebugMode) {
    final _ = FirebasePerformance.instance;
  }
}
