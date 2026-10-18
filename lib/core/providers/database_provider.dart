import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart';
import 'dart:async';

import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/database/app_database_lifecycle.dart';
import 'package:wm_app/core/database/platform_connection.dart';
import 'package:wm_app/core/constants/app_constants.dart';

part 'database_provider.g.dart';

QueryExecutor _openConnection() =>
    openPlatformDatabase(databaseName: AppConstants.databaseName);

final appDatabaseLifecycleProvider =
    StateNotifierProvider<AppDatabaseLifecycle, AppDatabase>((ref) {
  final lifecycle = AppDatabaseLifecycle(() => AppDatabase(_openConnection()));
  ref.onDispose(() => unawaited(lifecycle.closeCurrent()));
  return lifecycle;
});

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) => ref.watch(appDatabaseLifecycleProvider);
