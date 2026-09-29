# MediaLib architecture

## Principles

1. **Local-first.** The authoritative copy of the library is a SQLite database on
   the user's device. There is no account and no server.
2. **Offline by default.** Every screen works without a network connection.
   Metadata is optional enrichment, cached locally and never required to read
   or edit the library.
3. **Portable data.** A documented JSON export/import keeps the user in control
   and avoids vendor lock-in.
4. **Layered, testable code.** A shared `core` layer holds infrastructure;
   `features/*` hold vertical slices of functionality that depend on `core`,
   never the reverse.

## Layers

```
core/                      # shared infrastructure (no feature dependencies)
  database/                # Drift schema, DAOs, database, Riverpod providers
  repositories/            # domain-level data access over DAOs
  router/                  # go_router configuration + navigation model
  settings/                # settings keys + live settings providers
  theme/                   # Forui theme construction + persisted theme mode
  widgets/                 # shared UI (confirm dialog, media icons, placeholders)

features/<name>/           # vertical slices
  domain/                  # pure types (metadata providers)
  data/                    # services / provider implementations
  presentation/            # widgets, screens, feature providers
```

Dependencies flow inward: `features/*` may import `core/*`, but `core/*` never
imports a feature.

## State management

[Riverpod] is used throughout.

- `Provider` for stateless singletons (database, repositories, services).
- `StreamProvider` for reactive database queries (the UI rebuilds automatically
  when rows change).
- `NotifierProvider` for mutable UI state (library filters, settings, theme).

Providers are declared next to what they serve: infrastructure providers in
`core/*/…_providers.dart`, feature providers in `features/<name>/presentation/…_providers.dart`.

## Navigation

`go_router` with a `StatefulShellRoute.indexedStack`:

- Five top-level branches: **Library, Search, History, Orders, Settings**, each
  keeping its own navigation stack.
- A responsive `AppShell` renders a sidebar on wide layouts (≥ 768 px,
  `FBreakpoints.md`) and a bottom navigation bar on narrow ones.
- The entry editor is a **top-level route** (`/editor` and `/editor/:id`) that
  covers the shell with its own scaffold.

## Data model

One unified `MediaItems` table covers all eight media types; type-specific
values are nullable columns.

| Table                   | Purpose                                              |
| ----------------------- | ---------------------------------------------------- |
| `MediaItems`            | A library entry (title, type, status, progress, …)   |
| `Franchises`            | A franchise/series grouping several entries          |
| `WatchOrders`           | A community/user watching or reading order           |
| `WatchOrderSteps`       | One ordered step of an order (optionally an entry)   |
| `HistoryEntries`        | Consumption timeline events                          |
| `MetadataCacheEntries`  | Cached provider payloads per entry                   |
| `Tags` / `MediaItemTags`| User tags and their links to entries                 |
| `AppSettings`           | Key/value application settings (e.g. API keys)       |

Design choices:

- **UUID text primary keys** keep records mergeable if multi-device sync is
  added later.
- **Enums are stored by name** via drift `textEnum`, so reordering values is
  safe.
- **Foreign keys** cascade from entries (history, cache, tag links) and null
  out references from entries/orders to franchises.
- The database enables `PRAGMA foreign_keys = ON` on open.

Repositories (`core/repositories/`) wrap DAOs and hold domain rules — for
example, `MediaRepository.setStatus` and `updateProgress` also append a
`HistoryEntries` row.

## Metadata pipeline

```
MetadataSearchDialog ──▶ MetadataService ──▶ MetadataProvider (AniList / Open Library / MusicBrainz / TMDB)
                              │
                              └──▶ MetadataRepository ──▶ MetadataCacheEntries
```

- `MetadataProvider` is a small interface (`id`, `name`, `supportedTypes`,
  `search`, `fetch`); `MetadataProviderRegistry` looks providers up by id or
  media type.
- `MetadataService.search` fans out across applicable providers and **swallows
  individual failures**, so one unavailable source never blocks the rest.
- Applying a result fills the editor's fields and records
  `externalSource`/`externalId`; the fetched payload is cached against the entry.
- Keyless providers are always registered. TMDB is registered only once its API
  key is stored in `AppSettings` (the pure `buildMetadataProviders` helper makes
  this easy to test).

## Export format

`LibraryTransferService` produces a `medialib.library` v1 document:

```json
{
  "format": "medialib.library",
  "version": 1,
  "exportedAt": "2026-09-30T12:00:00.000Z",
  "data": {
    "franchises": [ … ],
    "mediaItems": [ … ],
    "tags": [ … ],
    "mediaItemTags": [ … ],
    "watchOrders": [ … ],
    "watchOrderSteps": [ … ],
    "historyEntries": [ … ]
  }
}
```

Rows are serialised by drift's generated `toJson`, using a serializer that
writes `DateTime` values as ISO-8601 strings. Imports **merge** by primary key
or **replace** the library after clearing it, inserting parents before children
so foreign keys resolve.

## Theming & platform adaptation

- Forui's `neutral` theme provides light/dark and touch/desktop variants.
- `ThemeController` persists the theme mode (`system`/`light`/`dark`) with
  `SharedPreferencesAsync`.
- This Flutter version splits Material into the `material_ui` package; the app
  imports `package:material_ui/material_ui.dart` so widget types match Forui's
  `toApproximateMaterialTheme()`.

## Testing conventions

- **Database/repository tests** open
  `AppDatabase.forTesting(NativeDatabase.memory())`.
- **Provider/service tests** inject a `MockClient` (from `package:http/testing`)
  so no real network request is made.
- **Widget tests** override `appDatabaseProvider` with an in-memory database and
  drive frames with explicit pumps (the library shows an indeterminate spinner
  while loading, so `pumpAndSettle` would never settle). Tests unmount the app
  (`pumpWidget(const SizedBox.shrink())` + a pump) before finishing to flush
  drift's stream-query timers.
