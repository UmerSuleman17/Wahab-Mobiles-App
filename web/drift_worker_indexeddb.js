// Force Drift's compatibility probe to use persistent IndexedDB rather than
// waiting on an OPFS capability check in Chromium builds where it stalls.
try {
  const storage = self.navigator?.storage;
  if (storage?.getDirectory) {
    Object.defineProperty(storage, 'getDirectory', {
      configurable: true,
      value: () => Promise.reject(new Error('OPFS is disabled for WM_APP web')),
    });
  }
} catch (_) {
  // The worker still reports other supported persistent backends.
}

importScripts('drift_worker.dart.js');
