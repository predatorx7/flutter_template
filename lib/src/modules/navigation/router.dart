import 'package:example/build_options.dart';
import 'package:example/src/di/account.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magnific_core/magnific_core.dart';

import 'routes.dart';

final routerProviderRef = Provider((ref) {
  final routes = ref.read(navigationPaths);
  final accountManager = ref.read(accountManagerRef.notifier);

  return GoRouter(
    routes: routes,
    refreshListenable: GoRouterRefreshStream(accountManager.stream),
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
    redirect: ref.read(routerRootRedirection),
  );
});
