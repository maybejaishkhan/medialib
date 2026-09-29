import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'package:medialib/core/database/enums.dart';

/// Generates primary keys for newly inserted rows.
///
/// Kept public (rather than private) so the generated drift code, which lives
/// in the same library as the schema, can reference it.
const uuidGenerator = Uuid();

/// A single entry in the unified media library.
///
/// All media types share this table; type-specific values (`pageCount`,
/// `episodeCount`, `runtimeMinutes`, `trackCount`, `platform`, `isbn`, ...)
/// are nullable and only populated when relevant.
class MediaItems extends Table {
  TextColumn get id => text().clientDefault(() => uuidGenerator.v4())();
  TextColumn get title => text().withLength(min: 1, max: 500)();
  TextColumn get originalTitle => text().nullable()();
  TextColumn get mediaType => textEnum<MediaType>()();
  TextColumn get status =>
      textEnum<MediaStatus>().clientDefault(() => MediaStatus.planned.name)();
  TextColumn get description => text().nullable()();
  TextColumn get creators => text().nullable()();
  TextColumn get coverUrl => text().nullable()();
  DateTimeColumn get releaseDate => dateTime().nullable()();

  /// The user's own rating, 0–10.
  RealColumn get rating => real().nullable()();

  // Type-specific counts.
  IntColumn get pageCount => integer().nullable()();
  IntColumn get chapterCount => integer().nullable()();
  IntColumn get episodeCount => integer().nullable()();
  IntColumn get runtimeMinutes => integer().nullable()();
  IntColumn get trackCount => integer().nullable()();

  /// Games: the platform the game is played on.
  TextColumn get platform => text().nullable()();

  /// Books: the ISBN, used to match against metadata providers.
  TextColumn get isbn => text().nullable()();

  // Progress.
  IntColumn get progress => integer().withDefault(const Constant(0))();
  IntColumn get totalProgress => integer().nullable()();

  TextColumn get notes => text().nullable()();

  /// The franchise/series this entry belongs to, if any.
  TextColumn get franchiseId => text().nullable().references(
    Franchises,
    #id,
    onDelete: KeyAction.setNull,
  )();

  // Metadata provider linkage.
  TextColumn get externalSource => text().nullable()();
  TextColumn get externalId => text().nullable()();

  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get finishedAt => dateTime().nullable()();
  DateTimeColumn get addedAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();

  @override
  Set<Column> get primaryKey => {id};
}

/// A franchise or series that groups several [MediaItems].
class Franchises extends Table {
  TextColumn get id => text().clientDefault(() => uuidGenerator.v4())();
  TextColumn get name => text().withLength(min: 1, max: 300)();
  TextColumn get description => text().nullable()();
  TextColumn get mediaType => textEnum<MediaType>().nullable()();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();

  @override
  Set<Column> get primaryKey => {id};
}

/// A community-created or user-created watching/reading order.
class WatchOrders extends Table {
  TextColumn get id => text().clientDefault(() => uuidGenerator.v4())();
  TextColumn get name => text().withLength(min: 1, max: 300)();
  TextColumn get description => text().nullable()();
  TextColumn get author => text().nullable()();

  /// The franchise this order applies to, if it is tied to one.
  TextColumn get franchiseId => text().nullable().references(
    Franchises,
    #id,
    onDelete: KeyAction.setNull,
  )();

  /// Whether the user authored this order locally.
  BoolColumn get isUserCreated =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();

  @override
  Set<Column> get primaryKey => {id};
}

/// One step in a [WatchOrders] sequence.
class WatchOrderSteps extends Table {
  TextColumn get id => text().clientDefault(() => uuidGenerator.v4())();
  TextColumn get orderId =>
      text().references(WatchOrders, #id, onDelete: KeyAction.cascade)();

  /// Zero-based position within the order.
  IntColumn get position => integer()();

  /// The library entry this step refers to, if it has been added.
  TextColumn get mediaItemId => text().nullable().references(
    MediaItems,
    #id,
    onDelete: KeyAction.setNull,
  )();

  /// The title of the work, kept even when it is not in the library yet.
  TextColumn get title => text().withLength(min: 1, max: 500)();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// A single event in the user's consumption history.
class HistoryEntries extends Table {
  TextColumn get id => text().clientDefault(() => uuidGenerator.v4())();
  TextColumn get mediaItemId =>
      text().references(MediaItems, #id, onDelete: KeyAction.cascade)();
  TextColumn get eventType => textEnum<HistoryEventType>()();
  DateTimeColumn get occurredAt => dateTime().clientDefault(DateTime.now)();
  IntColumn get progress => integer().nullable()();
  RealColumn get rating => real().nullable()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// A cached response from an external metadata provider.
class MetadataCacheEntries extends Table {
  TextColumn get id => text().clientDefault(() => uuidGenerator.v4())();
  TextColumn get mediaItemId =>
      text().references(MediaItems, #id, onDelete: KeyAction.cascade)();

  /// The provider the data came from, e.g. `anilist` or `tmdb`.
  TextColumn get source => text()();

  /// The provider-specific identifier the data was fetched with.
  TextColumn get externalId => text().nullable()();

  /// The raw JSON payload, stored verbatim so it can be re-parsed later.
  TextColumn get payload => text()();
  DateTimeColumn get fetchedAt => dateTime().clientDefault(DateTime.now)();

  @override
  Set<Column> get primaryKey => {id};
}

/// A user-defined tag that can be attached to entries.
class Tags extends Table {
  TextColumn get id => text().clientDefault(() => uuidGenerator.v4())();
  TextColumn get name => text().withLength(min: 1, max: 100)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Join table linking [MediaItems] to [Tags].
class MediaItemTags extends Table {
  TextColumn get mediaItemId =>
      text().references(MediaItems, #id, onDelete: KeyAction.cascade)();
  TextColumn get tagId =>
      text().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {mediaItemId, tagId};
}

/// Simple key/value storage for application settings.
class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime().clientDefault(DateTime.now)();

  @override
  Set<Column> get primaryKey => {key};
}
