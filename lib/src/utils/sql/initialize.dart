import 'disposable.dart';
import 'init/unsupported.dart'
    if (dart.library.ffi) 'init/native.dart'
    if (dart.library.html) 'init/web.dart';

Disposable initializePlatformDatabase() => $init();
