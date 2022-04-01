import 'package:example/build_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magnific_core/magnific_core.dart';

import 'paths.dart';

final routerProviderRef = Provider((ref) {
  final paths = ref.read(navigationPaths);

  return GoRouter(
    routes: paths,
    observers: [
      if (packageSupportInfo.isFirebaseSupported)
        FirebaseAnalyticsObserver(
          analytics: FirebaseAnalytics.instance,
          onError: (e) {
            logger.warning(
              'Failed to send navigation analytics to firebase',
              e,
            );
          },
        ),
    ],
  );
});
