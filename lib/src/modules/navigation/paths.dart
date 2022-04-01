import 'package:example/src/ui/main/launch.dart';
import 'package:example/src/ui/screen/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

T? getTypeIf<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

final navigationPaths = Provider<List<GoRoute>>(
  (ref) {
    return [
      GoRoute(
        name: AppLaunchScreen.routeName,
        path: AppLaunchScreen.routeName,
        builder: (context, s) {
          final redirectPath = getTypeIf<String>(s.queryParams['redirect']);

          return AppLaunchScreen(
            routePath: redirectPath,
            reRoutePath: HomeScreen.routeName,
          );
        },
      ),
      GoRoute(
        name: HomeScreen.routeName,
        path: HomeScreen.routeName,
        builder: (context, s) {
          return const HomeScreen();
        },
      ),
    ];
  },
);
