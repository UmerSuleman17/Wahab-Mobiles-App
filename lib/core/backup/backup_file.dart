import 'dart:typed_data';

final class PickedBackupFile {
  const PickedBackupFile({
    required this.name,
    this.bytes,
    this.nativePath,
  });

  final String name;
  final Uint8List? bytes;
  final String? nativePath;
}

abstract interface class BackupFileAdapter {
  Future<PickedBackupFile?> pickBackup();

  /// Returns false if the user dismissed the save dialog.
  Future<bool> saveBackup(Uint8List bytes, String suggestedName);
}
