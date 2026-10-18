import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:wm_app/core/backup/backup_file.dart';
import 'package:wm_app/core/providers/backup_file_adapter.dart';
import 'package:wm_app/core/providers/legacy_backup_restorer.dart';
import 'package:wm_app/core/providers/portable_backup_service.dart';
import 'package:wm_app/services/portable_backup_service.dart';

class BackupRestoreScreen extends ConsumerStatefulWidget {
  const BackupRestoreScreen({super.key});

  @override
  ConsumerState<BackupRestoreScreen> createState() =>
      _BackupRestoreScreenState();
}

class _BackupRestoreScreenState extends ConsumerState<BackupRestoreScreen> {
  bool _busy = false;
  DateTime? _lastBackupAt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Backup & Restore')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Icon(Icons.backup_outlined, size: 64, color: Colors.blue),
          const SizedBox(height: 16),
          const Text(
            'Create a backup file to protect your business data or move it to '
            'another WM_APP installation.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Last backup'),
              subtitle: Text(
                _lastBackupAt == null
                    ? 'No backup created in this session'
                    : DateFormat.yMMMd()
                        .add_jm()
                        .format(_lastBackupAt!.toLocal()),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _busy ? null : _exportBackup,
            icon: const Icon(Icons.download),
            label: const Text('Create New Backup'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _busy ? null : _pickAndRestoreBackup,
            icon: const Icon(Icons.upload_file),
            label: const Text('Restore from Backup'),
          ),
          if (_busy) ...[
            const SizedBox(height: 20),
            const Center(child: CircularProgressIndicator()),
          ],
          const SizedBox(height: 24),
          const _BackupSafetyGuidance(),
        ],
      ),
    );
  }

  Future<void> _exportBackup() async {
    setState(() => _busy = true);
    try {
      final bytes =
          await ref.read(portableBackupServiceProvider).exportBackup();
      final timestamp = DateTime.now().toUtc();
      final stamp = DateFormat('yyyyMMdd_HHmmss').format(timestamp);
      final saved = await ref
          .read(backupFileAdapterProvider)
          .saveBackup(bytes, 'wm_app_backup_$stamp.wmbak');
      if (!mounted) return;
      if (saved) {
        setState(() => _lastBackupAt = timestamp);
        _showMessage('Backup file created. Store it somewhere private.');
      }
    } on Object {
      if (mounted) _showMessage('Backup could not be created.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _pickAndRestoreBackup() async {
    PickedBackupFile? file;
    try {
      file = await ref.read(backupFileAdapterProvider).pickBackup();
    } on Object {
      if (mounted) _showMessage('The selected backup could not be read.');
      return;
    }
    if (!mounted || file == null) return;

    if (file.name.toLowerCase().endsWith('.db')) {
      await _restoreLegacyDatabase(file);
      return;
    }

    final bytes = file.bytes;
    if (bytes == null) {
      _showMessage('The selected backup could not be read.');
      return;
    }

    final PortableBackupSummary summary;
    try {
      summary = ref.read(portableBackupServiceProvider).inspectBackup(bytes);
    } on Object {
      _showMessage('Backup could not be read. Choose a valid WM_APP backup.');
      return;
    }

    final confirmed = await _confirmPortableRestore(file.name, summary);
    if (!mounted || confirmed != true) return;
    await _runRestore(
        () => ref.read(portableBackupServiceProvider).restoreBackup(summary));
  }

  Future<void> _restoreLegacyDatabase(PickedBackupFile file) async {
    final path = file.nativePath;
    final restorer = ref.read(legacyBackupRestorerProvider);
    if (path == null || restorer == null) {
      _showMessage('Native database backups are unavailable on this platform.');
      return;
    }

    final bool valid;
    try {
      valid = await restorer.validateBackup(path);
    } on Object {
      _showMessage('The selected database backup could not be validated.');
      return;
    }
    if (!mounted) return;
    if (!valid) {
      _showMessage('This database backup is invalid or unsupported.');
      return;
    }

    final confirmed = await _confirmLegacyRestore(file.name);
    if (!mounted || confirmed != true) return;
    await _runRestore(() => restorer.restoreBackup(path));
  }

  Future<bool?> _confirmPortableRestore(
    String fileName,
    PortableBackupSummary summary,
  ) {
    final totalRows =
        summary.rowCounts.values.fold<int>(0, (sum, n) => sum + n);
    final exportedAt =
        DateFormat.yMMMd().add_jm().format(summary.exportedAtUtc.toLocal());
    final recordLabel = totalRows == 1 ? 'record' : 'records';
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Replace current data?'),
        content: Text(
          'File: $fileName\n'
          'Exported: $exportedAt\n'
          'Contains $totalRows $recordLabel across '
          '${summary.rowCounts.length} tables. '
          'Restoring replaces all current business data.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Replace data'),
          ),
        ],
      ),
    );
  }

  Future<bool?> _confirmLegacyRestore(String fileName) => showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Replace current data?'),
          content: Text(
            'Restore the validated native database backup "$fileName"? '
            'This replaces all current business data.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Replace data'),
            ),
          ],
        ),
      );

  Future<void> _runRestore(Future<void> Function() restore) async {
    setState(() => _busy = true);
    try {
      await restore();
      if (mounted) _showMessage('Restore complete');
    } on Object {
      if (mounted) _showMessage('Restore failed. Your previous data was kept.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _showMessage(String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _BackupSafetyGuidance extends StatelessWidget {
  const _BackupSafetyGuidance();

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Keep your data safe',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              const Text(
                'On the web, data stays in this browser profile. Clearing site '
                'storage can permanently erase it. Private browsing may not '
                'keep data after the window closes. Export backups regularly '
                'and store them securely; backup files contain sensitive '
                'business information.',
              ),
            ],
          ),
        ),
      );
}
