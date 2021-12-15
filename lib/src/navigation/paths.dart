import 'package:example/src/ui/launch.dart';
import 'package:example/src/ui/screen/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigator/navigator.dart';

final navigationPaths = Provider<List<NavigationPath>>(
  (ref) {
    return [
      NavigationPath(
        matcher: (a) => a?.name == AppLaunchScreen.routeName,
        builder: (context, s) {
          final _arg = s.arguments;
          return AppLaunchScreen(
            routePath: _arg is String ? _arg : null,
            reRoutePath: HomeScreen.routeName,
          );
        },
      ),
      NavigationPath(
        matcher: (s) => s?.name == HomeScreen.routeName,
        builder: (context, s) {
          return const HomeScreen();
        },
      ),
    ];
  },
);
