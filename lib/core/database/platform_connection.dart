import 'package:drift/drift.dart';

import 'platform_connection_stub.dart'
    if (dart.library.io) 'platform_connection_native.dart'
    if (dart.library.js_interop) 'platform_connection_web.dart' as platform;

QueryExecutor openPlatformDatabase({required String databaseName}) =>
    platform.openPlatformDatabase(databaseName: databaseName);
