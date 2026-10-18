const trace = new BroadcastChannel('drift-worker-diagnostics');
function log(message) {
  trace.postMessage(`${self.constructor.name}: ${message}`);
}

function instrument(target, label) {
  const add = target.addEventListener;
  target.addEventListener = function (type, listener, options) {
    if (type !== 'message' && type !== 'connect') {
      return add.call(this, type, listener, options);
    }
    const wrapped = function (event) {
      const data = event.data;
      log(`${label} received ${type}: ${data?.type ?? data?.constructor?.name ?? 'unknown'}`);
      try {
        return listener.call(this, event);
      } catch (error) {
        log(`${label} listener threw: ${error?.stack ?? error}`);
        throw error;
      }
    };
    return add.call(this, type, wrapped, options);
  };
}

instrument(self, 'worker');
instrument(MessagePort.prototype, 'port');

const portPostMessage = MessagePort.prototype.postMessage;
MessagePort.prototype.postMessage = function (data, transfer) {
  log(`port posting ${data?.type ?? data?.constructor?.name ?? typeof data}`);
  return portPostMessage.call(this, data, transfer);
};

if (typeof self.postMessage === 'function') {
  const workerPostMessage = self.postMessage.bind(self);
  self.postMessage = function (data, transfer) {
    log(`worker posting ${data?.type ?? data?.constructor?.name ?? typeof data}`);
    return workerPostMessage(data, transfer);
  };
}

self.addEventListener('error', event => log(`global error: ${event.message}`));
self.addEventListener('unhandledrejection', event =>
  log(`unhandled rejection: ${event.reason?.stack ?? event.reason}`));

// Keep this diagnostic worker on the IndexedDB path. Some Chromium builds
// expose OPFS but leave its synchronous-access feature probe pending.
try {
  log(`scope=${self.constructor.name}; storage=${typeof self.navigator?.storage}; ` +
      `getDirectory=${typeof self.navigator?.storage?.getDirectory}; ` +
      `indexedDB=${typeof self.indexedDB}; FileReader=${typeof self.FileReader}`);
  if (self.navigator?.storage?.getDirectory) {
    Object.defineProperty(self.navigator.storage, 'getDirectory', {
      configurable: true,
      value: () => {
        log('OPFS getDirectory intercepted');
        return Promise.reject(new Error('OPFS disabled for diagnostic'));
      },
    });
  }
} catch (error) {
  log(`could not disable OPFS feature probe: ${error}`);
}

try {
  const idb = self.indexedDB;
  if (idb) {
    const open = idb.open.bind(idb);
    idb.open = (...args) => {
      log(`IndexedDB open ${args[0]}`);
      const request = open(...args);
      request.addEventListener('success', () => log(`IndexedDB success ${args[0]}`));
      request.addEventListener('error', () => log(`IndexedDB error ${args[0]}`));
      return request;
    };
  }
} catch (error) {
  log(`could not trace IndexedDB open: ${error}`);
}

importScripts('drift_worker.dart.js');
