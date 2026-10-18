import 'package:flutter_test/flutter_test.dart';
import 'package:wm_app/core/database/web_storage_policy.dart';

void main() {
  test('persistent web storage modes are accepted with the right tab policy',
      () {
    const modes = <({WebStorageMode mode, bool singleTabOnly})>[
      (mode: WebStorageMode.opfsShared, singleTabOnly: false),
      (mode: WebStorageMode.opfsLocks, singleTabOnly: false),
      (mode: WebStorageMode.sharedIndexedDb, singleTabOnly: false),
      (mode: WebStorageMode.unsafeIndexedDb, singleTabOnly: true),
    ];

    for (final (:mode, :singleTabOnly) in modes) {
      final policy = WebStoragePolicy.fromMode(mode);

      expect(policy.isPersistent, isTrue, reason: '$mode must persist data');
      expect(policy.requiresSingleTabNotice, singleTabOnly,
          reason: '$mode has the wrong tab-safety notice');
    }
  });

  test('in-memory web storage is rejected as non-persistent', () {
    expect(
      () => WebStoragePolicy.fromMode(WebStorageMode.inMemory),
      throwsA(isA<PersistentStorageUnavailableException>()),
    );
  });
}
