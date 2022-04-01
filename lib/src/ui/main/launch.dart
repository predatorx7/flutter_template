import 'dart:async';

import 'package:app_boot/app_boot.dart';
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
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    _animationNotifier.onCompleted();
  }

  @override
  void dispose() {
    _animationNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoLaunchScreen<DependencyObject>(
      routePath: widget.routePath,
      reRoutePath: widget.reRoutePath,
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

/// A launch or splash screen that is shown while app is loading.
///
/// It is recommended to create your own LaunchScreen Widget that uses [GoLaunchScreen].
///
/// Use [AnimatingSplash] as [child] to inform the app that the splash UI is done animating.
class GoLaunchScreen<T extends DependencyObject> extends StatefulWidget {
  static const String routeName = '/';

  final String? routePath;

  /// The navigator will navigate to this path if [routePath] is null
  final String reRoutePath;
  final DependencyObjectProviderCallback<T> dependencyObjectProvider;

  /// A widget that is shown while [GoLaunchScreen] is loading. This represents splash screen's UI. This could be animating [AnimatingSplash].
  /// A constant widget instance might lead to better splash performance.
  final Widget child;

  final SplashAnimatingNotifier? animatingNotifier;

  final void Function(Object error, StackTrace stackTrace)? onError;

  const GoLaunchScreen({
    Key? key,
    required this.routePath,
    required this.reRoutePath,
    required this.dependencyObjectProvider,
    required this.child,
    this.onError,
    this.animatingNotifier,
  }) : super(key: key);

  @override
  _GoLaunchScreenState createState() => _GoLaunchScreenState();
}

class _GoLaunchScreenState extends State<GoLaunchScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(onInitialized);
  }

  static final Completer<void> _completer = Completer<void>();

  Future<void> onInitialized() async {
    bool _canNavigate = true;
    await Future.wait(
      [
        onDependencyResolve(),
        onSplashScreenAnimating().then((value) {
          _canNavigate = value;
        }),
      ],
    );

    if (_canNavigate) {
      GoRouter.of(context).goNamed(
        widget.routePath ?? widget.reRoutePath,
      );
    }
  }

  Future<void> onDependencyResolve() async {
    if (!_completer.isCompleted) {
      try {
        await currentSettings.dependencies?.call(
          widget.dependencyObjectProvider(context),
        );
        _completer.complete();
      } catch (e, s) {
        widget.onError?.call(e, s);
      }
    }
  }

  Future<bool> onSplashScreenAnimating() {
    if (widget.animatingNotifier?.isAnimating == true) {
      return widget.animatingNotifier!.waitForChange();
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
