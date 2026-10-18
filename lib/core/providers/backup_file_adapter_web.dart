import 'dart:html' as html;
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:wm_app/core/backup/backup_file.dart';

BackupFileAdapter createBackupFileAdapter() => _WebBackupFileAdapter();

class _WebBackupFileAdapter implements BackupFileAdapter {
  @override
  Future<PickedBackupFile?> pickBackup() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['wmbak'],
      allowMultiple: false,
      withData: true,
    );
    if (result == null || result.files.isEmpty) return null;
    final file = result.files.single;
    final bytes = file.bytes;
    if (bytes == null) {
      throw const FormatException('The selected backup could not be read.');
    }
    return PickedBackupFile(name: file.name, bytes: bytes);
  }

  @override
  Future<bool> saveBackup(Uint8List bytes, String suggestedName) async {
    final blob = html.Blob([bytes], 'application/octet-stream');
    final url = html.Url.createObjectUrlFromBlob(blob);
    try {
      final anchor = html.AnchorElement(href: url)
        ..download = suggestedName
        ..style.display = 'none';
      html.document.body?.children.add(anchor);
      anchor.click();
      anchor.remove();
      return true;
    } finally {
      html.Url.revokeObjectUrl(url);
    }
  }
}
