try {
  self.postMessage(`start indexedDB=${typeof indexedDB}`);
  const request = indexedDB.open('wm_app_idb_worker_probe', 1);
  request.onupgradeneeded = () => self.postMessage('upgrade');
  request.onsuccess = () => {
    const database = request.result;
    database.close();
    indexedDB.deleteDatabase('wm_app_idb_worker_probe');
    self.postMessage('success');
  };
  request.onerror = () => self.postMessage(`error ${request.error}`);
  request.onblocked = () => self.postMessage('blocked');
} catch (error) {
  self.postMessage(`throw ${error}`);
}
