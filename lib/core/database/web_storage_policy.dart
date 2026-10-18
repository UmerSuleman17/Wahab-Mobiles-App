enum WebStorageMode {
  opfsShared,
  opfsLocks,
  sharedIndexedDb,
  unsafeIndexedDb,
  inMemory,
}

final class PersistentStorageUnavailableException implements Exception {
  const PersistentStorageUnavailableException();

  @override
  String toString() =>
      'Persistent browser storage is unavailable. Use a regular browser window '
      'with site storage enabled.';
}

final class WebStoragePolicy {
  WebStoragePolicy._(this.mode);

  factory WebStoragePolicy.fromMode(WebStorageMode mode) {
    if (mode == WebStorageMode.inMemory) {
      throw const PersistentStorageUnavailableException();
    }
    return WebStoragePolicy._(mode);
  }

  final WebStorageMode mode;

  bool get isPersistent => true;

  bool get requiresSingleTabNotice => mode == WebStorageMode.unsafeIndexedDb;

  String? get notice => requiresSingleTabNotice
      ? 'Keep WM_APP open in only one tab in this browser profile.'
      : null;
}

/// Set by the web database connection after Drift selects its storage mode.
/// Native platforms leave it null.
WebStoragePolicy? activeWebStoragePolicy;
