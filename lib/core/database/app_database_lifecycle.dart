import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';

/// Owns the active Drift instance so a restore can replace and reopen it.
class AppDatabaseLifecycle extends StateNotifier<AppDatabase> {
  AppDatabaseLifecycle(this._createDatabase) : super(_createDatabase());

  final AppDatabase Function() _createDatabase;
  bool _isClosed = false;

  Future<void> closeCurrent() async {
    if (_isClosed) return;
    await state.close();
    _isClosed = true;
  }

  Future<void> reopenCurrent() async {
    if (!_isClosed) await closeCurrent();

    final reopened = _createDatabase();
    try {
      await reopened.customSelect('SELECT 1').get();
    } catch (_) {
      await reopened.close();
      rethrow;
    }

    state = reopened;
    _isClosed = false;
  }
}
