import 'package:example/src/di/account.dart';
import 'package:example/src/ui/main/launch.dart';
import 'package:example/src/ui/screen/home.dart';
import 'package:example/src/ui/screen/login.dart';
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
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routeName,
        builder: (context, s) {
          return const LoginScreen();
        },
      ),
    ];
  },
);

final routerRootRedirection = Provider<GoRouterRedirect>((ref) {
  final accountManager = ref.read(accountManagerRef.notifier);

  return (state) {
    final sublocation = state.subloc;
    if (sublocation == AppLaunchScreen.routeName) {
      return null;
    }

    // redirect to the login page if the user is not logged in

    // if the user is not logged in, they need to login
    final loggedIn = accountManager.isAuthenticated;
    final loggingIn = sublocation == LoginScreen.routeName;

    // bundle the location the user is coming from into a query parameter
    late final fromp = state.subloc == '/' ? '' : '?from=${state.subloc}';
    if (!loggedIn) return loggingIn ? null : '${LoginScreen.routeName}$fromp';

    // if the user is logged in, send them where they were going before (or
    // home if they weren't going anywhere)
    if (loggingIn) return state.queryParams['from'] ?? '/';

    // no need to redirect at all
    return null;
  };
});
