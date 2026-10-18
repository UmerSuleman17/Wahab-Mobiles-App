import 'package:path_provider/path_provider.dart';
import 'package:wm_app/core/backup/legacy_backup_restorer.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/database/app_database_lifecycle.dart';
import 'package:wm_app/services/backup_service.dart';

LegacyBackupRestorer createLegacyBackupRestorer(
  AppDatabase database,
  AppDatabaseLifecycle lifecycle,
) =>
    BackupService(
      database,
      documentsDirectoryProvider: getApplicationDocumentsDirectory,
      closeDatabase: lifecycle.closeCurrent,
      reopenDatabase: lifecycle.reopenCurrent,
    );
