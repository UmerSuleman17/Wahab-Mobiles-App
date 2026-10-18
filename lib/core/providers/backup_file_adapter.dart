import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wm_app/core/backup/backup_file.dart';

import 'backup_file_adapter_stub.dart'
    if (dart.library.io) 'backup_file_adapter_io.dart'
    if (dart.library.html) 'backup_file_adapter_web.dart' as platform;

BackupFileAdapter createBackupFileAdapter() =>
    platform.createBackupFileAdapter();

final backupFileAdapterProvider =
    Provider<BackupFileAdapter>((ref) => createBackupFileAdapter());
