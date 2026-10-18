import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wm_app/core/providers/database_provider.dart';
import 'package:wm_app/services/portable_backup_service.dart';

final portableBackupServiceProvider = Provider<PortableBackupStore>(
  (ref) => PortableBackupService(ref.watch(appDatabaseProvider)),
);
