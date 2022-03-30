import 'package:flutter/material.dart';

/// Displays a [Banner] saying "DEBUG" when running in checked mode.
/// [MaterialApp] builds one of these by default.
/// Does nothing in release mode.
class CustomModeBanner extends StatelessWidget {
  /// Creates a const checked mode banner.
  const CustomModeBanner({
    Key? key,
    required this.child,
    required this.label,
  }) : super(key: key);

  /// The widget to show behind the banner.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  final String? label;

  @override
  Widget build(BuildContext context) {
    final _isEnabled = label != null;
    if (!_isEnabled) return child;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Banner(
        message: label!,
        textDirection: TextDirection.ltr,
        location: BannerLocation.bottomStart,
        child: child,
      ),
    );
  }
}
