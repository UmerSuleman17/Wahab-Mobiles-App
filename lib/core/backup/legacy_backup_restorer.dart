abstract interface class LegacyBackupRestorer {
  Future<bool> validateBackup(String path);

  Future<void> restoreBackup(String path);
}
