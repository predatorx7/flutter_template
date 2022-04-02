import 'dart:async';

import 'package:app_boot/screen/launch.dart';
import 'package:example/src/commons/settings.dart';
import 'package:example/src/ui/widget/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magnific_core/magnific_core.dart';

class AppLaunchScreen extends ConsumerStatefulWidget {
  static const routeName = '/';

  final String? routePath;
  final String reRoutePath;

  const AppLaunchScreen({
    Key? key,
    required this.routePath,
    required this.reRoutePath,
  }) : super(key: key);

  @override
  ConsumerState<AppLaunchScreen> createState() => _AppLaunchScreenState();
}

class _AppLaunchScreenState extends ConsumerState<AppLaunchScreen> {
  late SplashAnimatingNotifier _animationNotifier;

  @override
  void initState() {
    super.initState();
    _animationNotifier = SplashAnimatingNotifier();
    _animationNotifier.onStarted();
    _stopAfterDelay();
  }

  void _stopAfterDelay() async {
    await Future.delayed(durationOfSplashWithoutAnimations);
    if (mounted) {
      _animationNotifier.onCompleted();
    }
  }

  @override
  void dispose() {
    _animationNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LaunchScreen(
      routePath: widget.routePath,
      reRoutePath: widget.reRoutePath,
      animatingNotifier: _animationNotifier,
      onNavigate: (context, routeName) {
        GoRouter.of(context).goNamed(
          routeName,
        );
        return Future.value(null);
      },
      dependencyObjectProvider: (context) {
        return AppDependency(context, ref);
      },
      onError: (e, s) {
        logger.severe('Error on launch screen', e, s);
      },
      child: splashWithoutAnimationUI,
    );
  }
}
