import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wm_app/core/backup/legacy_backup_restorer.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/database/app_database_lifecycle.dart';
import 'package:wm_app/core/providers/database_provider.dart';

import 'legacy_backup_restorer_factory_stub.dart'
    if (dart.library.io) 'legacy_backup_restorer_factory_io.dart' as platform;

LegacyBackupRestorer? createLegacyBackupRestorer(
  AppDatabase database,
  AppDatabaseLifecycle lifecycle,
) =>
    platform.createLegacyBackupRestorer(database, lifecycle);

final legacyBackupRestorerProvider = Provider<LegacyBackupRestorer?>((ref) {
  final database = ref.watch(appDatabaseProvider);
  final lifecycle = ref.read(appDatabaseLifecycleProvider.notifier);
  return createLegacyBackupRestorer(database, lifecycle);
});
