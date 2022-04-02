import 'package:flutter/material.dart';
import 'package:magnific_core/magnific_core.dart';

class _AppSplashFragment extends StatelessWidget {
  const _AppSplashFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final overlay = AppSystemUIOverlayStyle.fromColor(
      Colors.white,
      statusBarBrightness: Brightness.dark,
      navigationBarBrightness: Brightness.dark,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        // ignore: deprecated_member_use
        brightness: Brightness.light,
        systemOverlayStyle: overlay,
      ),
      body: const Center(
        child: Text('Example'),
      ),
    );
  }
}

const splashWithoutAnimationUI = _AppSplashFragment();

const durationOfSplashWithoutAnimations = Duration(milliseconds: 1500);
