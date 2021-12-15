import 'package:app_boot/app_boot.dart';
import 'package:app_boot/screen/launch.dart';
import 'package:example/src/commons/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magnific_core/magnific_core.dart';

import 'widget/splash.dart';

class AppLaunchScreen extends ConsumerWidget {
  static const routeName = '/';

  final String? routePath;
  final String reRoutePath;

  const AppLaunchScreen({
    Key? key,
    required this.routePath,
    required this.reRoutePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LaunchScreen<DependencyObject>(
      routePath: routePath,
      reRoutePath: reRoutePath,
      dependencyObjectProvider: (context) {
        return AppDependency(context, ref);
      },
      onError: (e, s) {
        logger.severe('Error on launch screen', e, s);
      },
      child: appSplashScreen,
    );
  }
}
