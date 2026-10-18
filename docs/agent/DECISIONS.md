# Decisions and constraints

Updated 2026-10-15. This records verified constraints; no new product or architecture decision was made during the bootstrap audit.

## Existing product constraints

- Keep the initial app offline-first and scoped to one local business/admin.
- Do not introduce cloud sync or multi-user behavior without a product decision.
- Continue with Flutter, Riverpod, Drift/SQLite, repositories, services, and presentation layers already in the project.
- Preserve financial history and perform compound business writes atomically.

## Decisions still needed

- Supported currencies and their precision, including whether the long-term persisted representation should use integer minor units or another exact decimal approach.
- PIN KDF implementation and versioned on-disk credential format. The existing deterministic Base64 format must be migrated safely after successful legacy authentication.
- Git initialization and local-data exclusion policy. The repository had no .git directory; this mission only asked for a proposal, so none was created.

## Mission 05 decisions (2026-10-16)

- **Web persistence:** each browser profile keeps an independent same-origin SQLite database in IndexedDB through `sqlite3.wasm` and `IndexedDbFileSystem`. The MVP has no cloud sync or cross-device sharing. Because the selected `unsafeIndexedDb` VFS does not coordinate concurrent tabs, the app warns users to keep one tab open.
- **Portable backup:** use `.wmbak` files containing UTF-8 JSON with format ID `wm_app_backup`, format version `1`, Drift schema version, UTC export time, and the complete logical snapshot of all 21 tables. Validate the exact format and table/column/row shape before confirmation; restore within one transaction. Keep the existing native `.db` validator and safe replacement lifecycle for legacy native backups.
- **Browser data safety:** clearing site storage may permanently erase a browser profile's database. The backup screen warns about storage clearing and private browsing and encourages secure manual exports. No automatic synchronization is introduced.
- No schema, money representation, or native business-service rules changed for web support. `file_picker` 8.0.3 was added directly without upgrading existing locked dependencies.

