# How to include drift_worker.dart in a web app?

Follow below instructions

# Debug mode

flutter pub run build_runner build --delete-conflicting-outputs -o web:build/web/;
cp -f build/web/drift_worker.dart.js web/drift_worker.dart.js;

# Release mode

flutter pub run build_runner build --release --delete-conflicting-outputs -o web:build/web/;
cp -f build/web/drift_worker.dart.js web/drift_worker.dart.min.js;
