import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:wm_app/core/backup/backup_file.dart';

BackupFileAdapter createBackupFileAdapter() => _IoBackupFileAdapter();

class _IoBackupFileAdapter implements BackupFileAdapter {
  @override
  Future<PickedBackupFile?> pickBackup() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['wmbak', 'db'],
      allowMultiple: false,
      withData: true,
    );
    if (result == null || result.files.isEmpty) return null;
    final file = result.files.single;
    return PickedBackupFile(
      name: file.name,
      bytes: file.bytes,
      nativePath: file.path,
    );
  }

  @override
  Future<bool> saveBackup(Uint8List bytes, String suggestedName) async {
    final path = await FilePicker.platform.saveFile(
      dialogTitle: 'Save WM_APP backup',
      fileName: suggestedName,
      type: FileType.custom,
      allowedExtensions: const ['wmbak'],
      bytes: bytes,
    );
    if (path == null) return false;
    // Some desktop implementations return a target path and leave writing to
    // the caller; platforms that write the supplied bytes already are safe to
    // overwrite with the same content.
    final file = File(path);
    if (!await file.exists() || await file.length() != bytes.length) {
      await file.writeAsBytes(bytes, flush: true);
    }
    return true;
  }
}
