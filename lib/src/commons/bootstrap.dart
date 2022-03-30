import 'package:cached_network_image/cached_network_image.dart';
import 'package:example/build_options.dart';
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

List<Future> onStarted() {
  cachedNetworkImageProviver = (it) => CachedNetworkImageProvider(it);
  return <Future>[
    _addFontLicense(),
  ];
}

Future<void> _addFontLicense() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}

Future<void> _initFirebase() async {
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
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
