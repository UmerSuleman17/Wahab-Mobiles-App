# Agent instructions

Read this file and docs/agent before making project changes. Treat PRD/PRD_APP.txt as the product requirements; verify older notes such as handoff.md against the current source.

## Product and architecture

- WM_APP is an offline-first Flutter app for one local business/admin. Do not introduce cloud sync, multi-user behavior, or a different persistence model without a product decision.
- Preserve the current Flutter, Riverpod, Drift/SQLite, repository, service, and presentation boundaries. Keep business rules in services, persistence in repositories/database code, and UI state in providers.
- Compound stock, sale, purchase, payment, cash, receipt, and audit writes must remain atomic in a Drift transaction. Reuse the ledger for stock/cash movements and preserve reversible transaction history.
- Monetary values currently use SQLite REAL and Dart double with rounding helpers. Do not silently change the representation; first document supported currency precision and migration needs.

## Security and data integrity

- Admin PIN storage is currently deterministic Base64 of a fixed-prefix string. Treat it as a pre-release security defect: do not copy this design, log PINs, or expand its use. Any replacement must include a safe legacy migration and tests.
- Do not physically delete financial history. Preserve foreign-key behavior and existing sale/purchase/payment balance semantics.
- Never use a real business database or backup as test data. Use in-memory or temporary databases for tests.
- Backup restore currently validates only file size and schemaVersion before copying over the active database. Do not run restore against user data; require integrity/version validation and a safe database lifecycle in any future repair.

## Change workflow

1. Read docs/agent/PROJECT_CONTEXT.md, DEVELOPMENT_STATE.md, DECISIONS.md, and NEXT_TASK.md.
2. Confirm current source and, when available, use Codebase Memory for symbol discovery and call paths. Treat graph edges as static hints; verify behavior in source and tests.
3. Keep each change to one bounded task with acceptance criteria. Add focused tests for changed behavior, then run the relevant analyzer and test commands.
4. Do not upgrade dependencies as part of unrelated work. Run code generation only when a changed annotated source requires it.
5. Update DEVELOPMENT_STATE.md and NEXT_TASK.md when findings, baseline results, or the recommended next task change.
6. This workspace had no Git repository at the bootstrap audit. Do not initialize Git without a separate user decision.
