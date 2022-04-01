import 'dart:ui';

class Disposable {
  const Disposable({
    VoidCallback? onDispose,
  }) : _onDispose = onDispose;

  final VoidCallback? _onDispose;

  void dispose() {
    if (_onDispose != null) _onDispose!();
  }
}
