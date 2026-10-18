# Backup Restore Hardening Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make backup restore reject invalid SQLite files and replace the active database only after staged validation, with reopen and rollback.

**Architecture:** Validate a staged copy using SQLite integrity, foreign-key, schema-version, and required-table checks. A Riverpod-owned database lifecycle closes the active Drift handle and publishes a newly opened handle after replacement, so providers follow the restored database.

**Tech Stack:** Flutter, Riverpod, Drift/SQLite, `sqlite3` 2.4.5, Dart temporary files.

**Spec:** `docs/agent/NEXT_TASK.md`, P0 backup-restore acceptance criteria.

## Global Constraints

- Keep restore offline and local and preserve the existing Drift persistence model.
- Do not use real business data or backups; tests use temporary databases and files.
- Reject invalid inputs before replacing the active database and preserve the previous file on replacement or reopen failure.
- Do not change money representation or upgrade dependencies.
- Do not initialize Git; the workspace has no repository and `AGENTS.md` requires a separate decision.

## Review Focus

- Missing, empty, non-SQLite, and truncated/corrupt files must fail validation without closing the active database; cover with validation and active-data-preservation tests.
- A valid SQLite file with a future `user_version` must be rejected; cover with an unsupported-version fixture.
- A same-version file missing an application table must be rejected; cover with a required-schema fixture.
- A valid backup must replace the active contents and survive close/reopen; cover with a temp-file restore test.
- Reopen failure after replacement must restore the prior database and leave it openable; cover with an injected one-shot open failure.

---

### Task 1: Validate and safely restore local SQLite backups

**Files:**
- Modify: `lib/services/backup_service.dart`
- Modify: `lib/core/providers/database_provider.dart`
- Modify: `lib/core/providers/service_providers.dart`
- Modify: `pubspec.yaml` (declare the already locked `sqlite3` runtime dependency)
- Test: `test/backup_service_test.dart`
- Modify: `docs/agent/DEVELOPMENT_STATE.md`
- Modify: `docs/agent/NEXT_TASK.md`

**Interfaces:**
- `AppDatabaseLifecycle.closeCurrent()` awaits closure of the current Drift database.
- `AppDatabaseLifecycle.reopenCurrent()` opens and publishes a fresh `AppDatabase` against the active file.
- `BackupService.validateBackup(String filePath)` returns false unless SQLite integrity, foreign keys, `PRAGMA user_version`, and all application tables match the supported schema.
- `BackupService.restoreBackup(String filePath)` stages and validates the candidate, closes the active handle, replaces the file, reopens and verifies it, and restores the prior file on failure.

- [x] **Step 1: Write temporary-database tests first.** Cover invalid-file classes, unsupported version, missing tables, constraints and triggers, invalid restore preserving active data, valid restore with a second close/reopen, and reopen failure rollback.
- [x] **Step 2: Run the focused tests and confirm they fail because the required restore validation/lifecycle behavior is missing.** Regression tests for missing primary keys and unexpected triggers were observed failing before the validator fix.
- [x] **Step 3: Add the SQLite validator and staged replacement/rollback flow; add the Riverpod database lifecycle so provider consumers receive the reopened instance.**
- [x] **Step 4: Run focused backup tests, the relevant existing backend tests, `dart analyze lib test`, and `flutter analyze`; compare every failure to the recorded baseline.** The full suite has 24 passing tests and the same Splash pending-timer failure as baseline.
- [x] **Step 5: Update development state and next task with verified results and remaining platform limitations.**

---
