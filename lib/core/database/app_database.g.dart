// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FranchisesTable extends Franchises
    with TableInfo<$FranchisesTable, Franchise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FranchisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => uuidGenerator.v4(),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 300,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MediaType?, String> mediaType =
      GeneratedColumn<String>(
        'media_type',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<MediaType?>($FranchisesTable.$convertermediaTypen);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    mediaType,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'franchises';
  @override
  VerificationContext validateIntegrity(
    Insertable<Franchise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Franchise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Franchise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      mediaType: $FranchisesTable.$convertermediaTypen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}media_type'],
        ),
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FranchisesTable createAlias(String alias) {
    return $FranchisesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MediaType, String, String> $convertermediaType =
      const EnumNameConverter<MediaType>(MediaType.values);
  static JsonTypeConverter2<MediaType?, String?, String?> $convertermediaTypen =
      JsonTypeConverter2.asNullable($convertermediaType);
}

class Franchise extends DataClass implements Insertable<Franchise> {
  final String id;
  final String name;
  final String? description;
  final MediaType? mediaType;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Franchise({
    required this.id,
    required this.name,
    this.description,
    this.mediaType,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || mediaType != null) {
      map['media_type'] = Variable<String>(
        $FranchisesTable.$convertermediaTypen.toSql(mediaType),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FranchisesCompanion toCompanion(bool nullToAbsent) {
    return FranchisesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      mediaType: mediaType == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaType),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Franchise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Franchise(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      mediaType: $FranchisesTable.$convertermediaTypen.fromJson(
        serializer.fromJson<String?>(json['mediaType']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'mediaType': serializer.toJson<String?>(
        $FranchisesTable.$convertermediaTypen.toJson(mediaType),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Franchise copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<MediaType?> mediaType = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Franchise(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    mediaType: mediaType.present ? mediaType.value : this.mediaType,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Franchise copyWithCompanion(FranchisesCompanion data) {
    return Franchise(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Franchise(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('mediaType: $mediaType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, mediaType, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Franchise &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.mediaType == this.mediaType &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FranchisesCompanion extends UpdateCompanion<Franchise> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<MediaType?> mediaType;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FranchisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FranchisesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Franchise> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? mediaType,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (mediaType != null) 'media_type': mediaType,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FranchisesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<MediaType?>? mediaType,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FranchisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      mediaType: mediaType ?? this.mediaType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<String>(
        $FranchisesTable.$convertermediaTypen.toSql(mediaType.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FranchisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('mediaType: $mediaType, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MediaItemsTable extends MediaItems
    with TableInfo<$MediaItemsTable, MediaItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => uuidGenerator.v4(),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 500,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalTitleMeta = const VerificationMeta(
    'originalTitle',
  );
  @override
  late final GeneratedColumn<String> originalTitle = GeneratedColumn<String>(
    'original_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MediaType, String> mediaType =
      GeneratedColumn<String>(
        'media_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<MediaType>($MediaItemsTable.$convertermediaType);
  @override
  late final GeneratedColumnWithTypeConverter<MediaStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        clientDefault: () => MediaStatus.planned.name,
      ).withConverter<MediaStatus>($MediaItemsTable.$converterstatus);
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creatorsMeta = const VerificationMeta(
    'creators',
  );
  @override
  late final GeneratedColumn<String> creators = GeneratedColumn<String>(
    'creators',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverUrlMeta = const VerificationMeta(
    'coverUrl',
  );
  @override
  late final GeneratedColumn<String> coverUrl = GeneratedColumn<String>(
    'cover_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _releaseDateMeta = const VerificationMeta(
    'releaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> releaseDate = GeneratedColumn<DateTime>(
    'release_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
    'rating',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pageCountMeta = const VerificationMeta(
    'pageCount',
  );
  @override
  late final GeneratedColumn<int> pageCount = GeneratedColumn<int>(
    'page_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chapterCountMeta = const VerificationMeta(
    'chapterCount',
  );
  @override
  late final GeneratedColumn<int> chapterCount = GeneratedColumn<int>(
    'chapter_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _episodeCountMeta = const VerificationMeta(
    'episodeCount',
  );
  @override
  late final GeneratedColumn<int> episodeCount = GeneratedColumn<int>(
    'episode_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _runtimeMinutesMeta = const VerificationMeta(
    'runtimeMinutes',
  );
  @override
  late final GeneratedColumn<int> runtimeMinutes = GeneratedColumn<int>(
    'runtime_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _trackCountMeta = const VerificationMeta(
    'trackCount',
  );
  @override
  late final GeneratedColumn<int> trackCount = GeneratedColumn<int>(
    'track_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _platformMeta = const VerificationMeta(
    'platform',
  );
  @override
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
    'platform',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isbnMeta = const VerificationMeta('isbn');
  @override
  late final GeneratedColumn<String> isbn = GeneratedColumn<String>(
    'isbn',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<int> progress = GeneratedColumn<int>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalProgressMeta = const VerificationMeta(
    'totalProgress',
  );
  @override
  late final GeneratedColumn<int> totalProgress = GeneratedColumn<int>(
    'total_progress',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _franchiseIdMeta = const VerificationMeta(
    'franchiseId',
  );
  @override
  late final GeneratedColumn<String> franchiseId = GeneratedColumn<String>(
    'franchise_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES franchises (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _externalSourceMeta = const VerificationMeta(
    'externalSource',
  );
  @override
  late final GeneratedColumn<String> externalSource = GeneratedColumn<String>(
    'external_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _externalIdMeta = const VerificationMeta(
    'externalId',
  );
  @override
  late final GeneratedColumn<String> externalId = GeneratedColumn<String>(
    'external_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _finishedAtMeta = const VerificationMeta(
    'finishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> finishedAt = GeneratedColumn<DateTime>(
    'finished_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    originalTitle,
    mediaType,
    status,
    description,
    creators,
    coverUrl,
    releaseDate,
    rating,
    pageCount,
    chapterCount,
    episodeCount,
    runtimeMinutes,
    trackCount,
    platform,
    isbn,
    progress,
    totalProgress,
    notes,
    franchiseId,
    externalSource,
    externalId,
    startedAt,
    finishedAt,
    addedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<MediaItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('original_title')) {
      context.handle(
        _originalTitleMeta,
        originalTitle.isAcceptableOrUnknown(
          data['original_title']!,
          _originalTitleMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('creators')) {
      context.handle(
        _creatorsMeta,
        creators.isAcceptableOrUnknown(data['creators']!, _creatorsMeta),
      );
    }
    if (data.containsKey('cover_url')) {
      context.handle(
        _coverUrlMeta,
        coverUrl.isAcceptableOrUnknown(data['cover_url']!, _coverUrlMeta),
      );
    }
    if (data.containsKey('release_date')) {
      context.handle(
        _releaseDateMeta,
        releaseDate.isAcceptableOrUnknown(
          data['release_date']!,
          _releaseDateMeta,
        ),
      );
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    if (data.containsKey('page_count')) {
      context.handle(
        _pageCountMeta,
        pageCount.isAcceptableOrUnknown(data['page_count']!, _pageCountMeta),
      );
    }
    if (data.containsKey('chapter_count')) {
      context.handle(
        _chapterCountMeta,
        chapterCount.isAcceptableOrUnknown(
          data['chapter_count']!,
          _chapterCountMeta,
        ),
      );
    }
    if (data.containsKey('episode_count')) {
      context.handle(
        _episodeCountMeta,
        episodeCount.isAcceptableOrUnknown(
          data['episode_count']!,
          _episodeCountMeta,
        ),
      );
    }
    if (data.containsKey('runtime_minutes')) {
      context.handle(
        _runtimeMinutesMeta,
        runtimeMinutes.isAcceptableOrUnknown(
          data['runtime_minutes']!,
          _runtimeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('track_count')) {
      context.handle(
        _trackCountMeta,
        trackCount.isAcceptableOrUnknown(data['track_count']!, _trackCountMeta),
      );
    }
    if (data.containsKey('platform')) {
      context.handle(
        _platformMeta,
        platform.isAcceptableOrUnknown(data['platform']!, _platformMeta),
      );
    }
    if (data.containsKey('isbn')) {
      context.handle(
        _isbnMeta,
        isbn.isAcceptableOrUnknown(data['isbn']!, _isbnMeta),
      );
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('total_progress')) {
      context.handle(
        _totalProgressMeta,
        totalProgress.isAcceptableOrUnknown(
          data['total_progress']!,
          _totalProgressMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('franchise_id')) {
      context.handle(
        _franchiseIdMeta,
        franchiseId.isAcceptableOrUnknown(
          data['franchise_id']!,
          _franchiseIdMeta,
        ),
      );
    }
    if (data.containsKey('external_source')) {
      context.handle(
        _externalSourceMeta,
        externalSource.isAcceptableOrUnknown(
          data['external_source']!,
          _externalSourceMeta,
        ),
      );
    }
    if (data.containsKey('external_id')) {
      context.handle(
        _externalIdMeta,
        externalId.isAcceptableOrUnknown(data['external_id']!, _externalIdMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('finished_at')) {
      context.handle(
        _finishedAtMeta,
        finishedAt.isAcceptableOrUnknown(data['finished_at']!, _finishedAtMeta),
      );
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediaItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      originalTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_title'],
      ),
      mediaType: $MediaItemsTable.$convertermediaType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}media_type'],
        )!,
      ),
      status: $MediaItemsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      creators: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creators'],
      ),
      coverUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_url'],
      ),
      releaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}release_date'],
      ),
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating'],
      ),
      pageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_count'],
      ),
      chapterCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chapter_count'],
      ),
      episodeCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}episode_count'],
      ),
      runtimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}runtime_minutes'],
      ),
      trackCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_count'],
      ),
      platform: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform'],
      ),
      isbn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}isbn'],
      ),
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}progress'],
      )!,
      totalProgress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_progress'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      franchiseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}franchise_id'],
      ),
      externalSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_source'],
      ),
      externalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_id'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      finishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}finished_at'],
      ),
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}added_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MediaItemsTable createAlias(String alias) {
    return $MediaItemsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MediaType, String, String> $convertermediaType =
      const EnumNameConverter<MediaType>(MediaType.values);
  static JsonTypeConverter2<MediaStatus, String, String> $converterstatus =
      const EnumNameConverter<MediaStatus>(MediaStatus.values);
}

class MediaItem extends DataClass implements Insertable<MediaItem> {
  final String id;
  final String title;
  final String? originalTitle;
  final MediaType mediaType;
  final MediaStatus status;
  final String? description;
  final String? creators;
  final String? coverUrl;
  final DateTime? releaseDate;

  /// The user's own rating, 0–10.
  final double? rating;
  final int? pageCount;
  final int? chapterCount;
  final int? episodeCount;
  final int? runtimeMinutes;
  final int? trackCount;

  /// Games: the platform the game is played on.
  final String? platform;

  /// Books: the ISBN, used to match against metadata providers.
  final String? isbn;
  final int progress;
  final int? totalProgress;
  final String? notes;

  /// The franchise/series this entry belongs to, if any.
  final String? franchiseId;
  final String? externalSource;
  final String? externalId;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final DateTime addedAt;
  final DateTime updatedAt;
  const MediaItem({
    required this.id,
    required this.title,
    this.originalTitle,
    required this.mediaType,
    required this.status,
    this.description,
    this.creators,
    this.coverUrl,
    this.releaseDate,
    this.rating,
    this.pageCount,
    this.chapterCount,
    this.episodeCount,
    this.runtimeMinutes,
    this.trackCount,
    this.platform,
    this.isbn,
    required this.progress,
    this.totalProgress,
    this.notes,
    this.franchiseId,
    this.externalSource,
    this.externalId,
    this.startedAt,
    this.finishedAt,
    required this.addedAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || originalTitle != null) {
      map['original_title'] = Variable<String>(originalTitle);
    }
    {
      map['media_type'] = Variable<String>(
        $MediaItemsTable.$convertermediaType.toSql(mediaType),
      );
    }
    {
      map['status'] = Variable<String>(
        $MediaItemsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || creators != null) {
      map['creators'] = Variable<String>(creators);
    }
    if (!nullToAbsent || coverUrl != null) {
      map['cover_url'] = Variable<String>(coverUrl);
    }
    if (!nullToAbsent || releaseDate != null) {
      map['release_date'] = Variable<DateTime>(releaseDate);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<double>(rating);
    }
    if (!nullToAbsent || pageCount != null) {
      map['page_count'] = Variable<int>(pageCount);
    }
    if (!nullToAbsent || chapterCount != null) {
      map['chapter_count'] = Variable<int>(chapterCount);
    }
    if (!nullToAbsent || episodeCount != null) {
      map['episode_count'] = Variable<int>(episodeCount);
    }
    if (!nullToAbsent || runtimeMinutes != null) {
      map['runtime_minutes'] = Variable<int>(runtimeMinutes);
    }
    if (!nullToAbsent || trackCount != null) {
      map['track_count'] = Variable<int>(trackCount);
    }
    if (!nullToAbsent || platform != null) {
      map['platform'] = Variable<String>(platform);
    }
    if (!nullToAbsent || isbn != null) {
      map['isbn'] = Variable<String>(isbn);
    }
    map['progress'] = Variable<int>(progress);
    if (!nullToAbsent || totalProgress != null) {
      map['total_progress'] = Variable<int>(totalProgress);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || franchiseId != null) {
      map['franchise_id'] = Variable<String>(franchiseId);
    }
    if (!nullToAbsent || externalSource != null) {
      map['external_source'] = Variable<String>(externalSource);
    }
    if (!nullToAbsent || externalId != null) {
      map['external_id'] = Variable<String>(externalId);
    }
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || finishedAt != null) {
      map['finished_at'] = Variable<DateTime>(finishedAt);
    }
    map['added_at'] = Variable<DateTime>(addedAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MediaItemsCompanion toCompanion(bool nullToAbsent) {
    return MediaItemsCompanion(
      id: Value(id),
      title: Value(title),
      originalTitle: originalTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(originalTitle),
      mediaType: Value(mediaType),
      status: Value(status),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      creators: creators == null && nullToAbsent
          ? const Value.absent()
          : Value(creators),
      coverUrl: coverUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(coverUrl),
      releaseDate: releaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseDate),
      rating: rating == null && nullToAbsent
          ? const Value.absent()
          : Value(rating),
      pageCount: pageCount == null && nullToAbsent
          ? const Value.absent()
          : Value(pageCount),
      chapterCount: chapterCount == null && nullToAbsent
          ? const Value.absent()
          : Value(chapterCount),
      episodeCount: episodeCount == null && nullToAbsent
          ? const Value.absent()
          : Value(episodeCount),
      runtimeMinutes: runtimeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(runtimeMinutes),
      trackCount: trackCount == null && nullToAbsent
          ? const Value.absent()
          : Value(trackCount),
      platform: platform == null && nullToAbsent
          ? const Value.absent()
          : Value(platform),
      isbn: isbn == null && nullToAbsent ? const Value.absent() : Value(isbn),
      progress: Value(progress),
      totalProgress: totalProgress == null && nullToAbsent
          ? const Value.absent()
          : Value(totalProgress),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      franchiseId: franchiseId == null && nullToAbsent
          ? const Value.absent()
          : Value(franchiseId),
      externalSource: externalSource == null && nullToAbsent
          ? const Value.absent()
          : Value(externalSource),
      externalId: externalId == null && nullToAbsent
          ? const Value.absent()
          : Value(externalId),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      finishedAt: finishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedAt),
      addedAt: Value(addedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MediaItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaItem(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      originalTitle: serializer.fromJson<String?>(json['originalTitle']),
      mediaType: $MediaItemsTable.$convertermediaType.fromJson(
        serializer.fromJson<String>(json['mediaType']),
      ),
      status: $MediaItemsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      description: serializer.fromJson<String?>(json['description']),
      creators: serializer.fromJson<String?>(json['creators']),
      coverUrl: serializer.fromJson<String?>(json['coverUrl']),
      releaseDate: serializer.fromJson<DateTime?>(json['releaseDate']),
      rating: serializer.fromJson<double?>(json['rating']),
      pageCount: serializer.fromJson<int?>(json['pageCount']),
      chapterCount: serializer.fromJson<int?>(json['chapterCount']),
      episodeCount: serializer.fromJson<int?>(json['episodeCount']),
      runtimeMinutes: serializer.fromJson<int?>(json['runtimeMinutes']),
      trackCount: serializer.fromJson<int?>(json['trackCount']),
      platform: serializer.fromJson<String?>(json['platform']),
      isbn: serializer.fromJson<String?>(json['isbn']),
      progress: serializer.fromJson<int>(json['progress']),
      totalProgress: serializer.fromJson<int?>(json['totalProgress']),
      notes: serializer.fromJson<String?>(json['notes']),
      franchiseId: serializer.fromJson<String?>(json['franchiseId']),
      externalSource: serializer.fromJson<String?>(json['externalSource']),
      externalId: serializer.fromJson<String?>(json['externalId']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      finishedAt: serializer.fromJson<DateTime?>(json['finishedAt']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'originalTitle': serializer.toJson<String?>(originalTitle),
      'mediaType': serializer.toJson<String>(
        $MediaItemsTable.$convertermediaType.toJson(mediaType),
      ),
      'status': serializer.toJson<String>(
        $MediaItemsTable.$converterstatus.toJson(status),
      ),
      'description': serializer.toJson<String?>(description),
      'creators': serializer.toJson<String?>(creators),
      'coverUrl': serializer.toJson<String?>(coverUrl),
      'releaseDate': serializer.toJson<DateTime?>(releaseDate),
      'rating': serializer.toJson<double?>(rating),
      'pageCount': serializer.toJson<int?>(pageCount),
      'chapterCount': serializer.toJson<int?>(chapterCount),
      'episodeCount': serializer.toJson<int?>(episodeCount),
      'runtimeMinutes': serializer.toJson<int?>(runtimeMinutes),
      'trackCount': serializer.toJson<int?>(trackCount),
      'platform': serializer.toJson<String?>(platform),
      'isbn': serializer.toJson<String?>(isbn),
      'progress': serializer.toJson<int>(progress),
      'totalProgress': serializer.toJson<int?>(totalProgress),
      'notes': serializer.toJson<String?>(notes),
      'franchiseId': serializer.toJson<String?>(franchiseId),
      'externalSource': serializer.toJson<String?>(externalSource),
      'externalId': serializer.toJson<String?>(externalId),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'finishedAt': serializer.toJson<DateTime?>(finishedAt),
      'addedAt': serializer.toJson<DateTime>(addedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MediaItem copyWith({
    String? id,
    String? title,
    Value<String?> originalTitle = const Value.absent(),
    MediaType? mediaType,
    MediaStatus? status,
    Value<String?> description = const Value.absent(),
    Value<String?> creators = const Value.absent(),
    Value<String?> coverUrl = const Value.absent(),
    Value<DateTime?> releaseDate = const Value.absent(),
    Value<double?> rating = const Value.absent(),
    Value<int?> pageCount = const Value.absent(),
    Value<int?> chapterCount = const Value.absent(),
    Value<int?> episodeCount = const Value.absent(),
    Value<int?> runtimeMinutes = const Value.absent(),
    Value<int?> trackCount = const Value.absent(),
    Value<String?> platform = const Value.absent(),
    Value<String?> isbn = const Value.absent(),
    int? progress,
    Value<int?> totalProgress = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> franchiseId = const Value.absent(),
    Value<String?> externalSource = const Value.absent(),
    Value<String?> externalId = const Value.absent(),
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> finishedAt = const Value.absent(),
    DateTime? addedAt,
    DateTime? updatedAt,
  }) => MediaItem(
    id: id ?? this.id,
    title: title ?? this.title,
    originalTitle: originalTitle.present
        ? originalTitle.value
        : this.originalTitle,
    mediaType: mediaType ?? this.mediaType,
    status: status ?? this.status,
    description: description.present ? description.value : this.description,
    creators: creators.present ? creators.value : this.creators,
    coverUrl: coverUrl.present ? coverUrl.value : this.coverUrl,
    releaseDate: releaseDate.present ? releaseDate.value : this.releaseDate,
    rating: rating.present ? rating.value : this.rating,
    pageCount: pageCount.present ? pageCount.value : this.pageCount,
    chapterCount: chapterCount.present ? chapterCount.value : this.chapterCount,
    episodeCount: episodeCount.present ? episodeCount.value : this.episodeCount,
    runtimeMinutes: runtimeMinutes.present
        ? runtimeMinutes.value
        : this.runtimeMinutes,
    trackCount: trackCount.present ? trackCount.value : this.trackCount,
    platform: platform.present ? platform.value : this.platform,
    isbn: isbn.present ? isbn.value : this.isbn,
    progress: progress ?? this.progress,
    totalProgress: totalProgress.present
        ? totalProgress.value
        : this.totalProgress,
    notes: notes.present ? notes.value : this.notes,
    franchiseId: franchiseId.present ? franchiseId.value : this.franchiseId,
    externalSource: externalSource.present
        ? externalSource.value
        : this.externalSource,
    externalId: externalId.present ? externalId.value : this.externalId,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    finishedAt: finishedAt.present ? finishedAt.value : this.finishedAt,
    addedAt: addedAt ?? this.addedAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MediaItem copyWithCompanion(MediaItemsCompanion data) {
    return MediaItem(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      originalTitle: data.originalTitle.present
          ? data.originalTitle.value
          : this.originalTitle,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      status: data.status.present ? data.status.value : this.status,
      description: data.description.present
          ? data.description.value
          : this.description,
      creators: data.creators.present ? data.creators.value : this.creators,
      coverUrl: data.coverUrl.present ? data.coverUrl.value : this.coverUrl,
      releaseDate: data.releaseDate.present
          ? data.releaseDate.value
          : this.releaseDate,
      rating: data.rating.present ? data.rating.value : this.rating,
      pageCount: data.pageCount.present ? data.pageCount.value : this.pageCount,
      chapterCount: data.chapterCount.present
          ? data.chapterCount.value
          : this.chapterCount,
      episodeCount: data.episodeCount.present
          ? data.episodeCount.value
          : this.episodeCount,
      runtimeMinutes: data.runtimeMinutes.present
          ? data.runtimeMinutes.value
          : this.runtimeMinutes,
      trackCount: data.trackCount.present
          ? data.trackCount.value
          : this.trackCount,
      platform: data.platform.present ? data.platform.value : this.platform,
      isbn: data.isbn.present ? data.isbn.value : this.isbn,
      progress: data.progress.present ? data.progress.value : this.progress,
      totalProgress: data.totalProgress.present
          ? data.totalProgress.value
          : this.totalProgress,
      notes: data.notes.present ? data.notes.value : this.notes,
      franchiseId: data.franchiseId.present
          ? data.franchiseId.value
          : this.franchiseId,
      externalSource: data.externalSource.present
          ? data.externalSource.value
          : this.externalSource,
      externalId: data.externalId.present
          ? data.externalId.value
          : this.externalId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      finishedAt: data.finishedAt.present
          ? data.finishedAt.value
          : this.finishedAt,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('mediaType: $mediaType, ')
          ..write('status: $status, ')
          ..write('description: $description, ')
          ..write('creators: $creators, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('rating: $rating, ')
          ..write('pageCount: $pageCount, ')
          ..write('chapterCount: $chapterCount, ')
          ..write('episodeCount: $episodeCount, ')
          ..write('runtimeMinutes: $runtimeMinutes, ')
          ..write('trackCount: $trackCount, ')
          ..write('platform: $platform, ')
          ..write('isbn: $isbn, ')
          ..write('progress: $progress, ')
          ..write('totalProgress: $totalProgress, ')
          ..write('notes: $notes, ')
          ..write('franchiseId: $franchiseId, ')
          ..write('externalSource: $externalSource, ')
          ..write('externalId: $externalId, ')
          ..write('startedAt: $startedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('addedAt: $addedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    title,
    originalTitle,
    mediaType,
    status,
    description,
    creators,
    coverUrl,
    releaseDate,
    rating,
    pageCount,
    chapterCount,
    episodeCount,
    runtimeMinutes,
    trackCount,
    platform,
    isbn,
    progress,
    totalProgress,
    notes,
    franchiseId,
    externalSource,
    externalId,
    startedAt,
    finishedAt,
    addedAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.originalTitle == this.originalTitle &&
          other.mediaType == this.mediaType &&
          other.status == this.status &&
          other.description == this.description &&
          other.creators == this.creators &&
          other.coverUrl == this.coverUrl &&
          other.releaseDate == this.releaseDate &&
          other.rating == this.rating &&
          other.pageCount == this.pageCount &&
          other.chapterCount == this.chapterCount &&
          other.episodeCount == this.episodeCount &&
          other.runtimeMinutes == this.runtimeMinutes &&
          other.trackCount == this.trackCount &&
          other.platform == this.platform &&
          other.isbn == this.isbn &&
          other.progress == this.progress &&
          other.totalProgress == this.totalProgress &&
          other.notes == this.notes &&
          other.franchiseId == this.franchiseId &&
          other.externalSource == this.externalSource &&
          other.externalId == this.externalId &&
          other.startedAt == this.startedAt &&
          other.finishedAt == this.finishedAt &&
          other.addedAt == this.addedAt &&
          other.updatedAt == this.updatedAt);
}

class MediaItemsCompanion extends UpdateCompanion<MediaItem> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> originalTitle;
  final Value<MediaType> mediaType;
  final Value<MediaStatus> status;
  final Value<String?> description;
  final Value<String?> creators;
  final Value<String?> coverUrl;
  final Value<DateTime?> releaseDate;
  final Value<double?> rating;
  final Value<int?> pageCount;
  final Value<int?> chapterCount;
  final Value<int?> episodeCount;
  final Value<int?> runtimeMinutes;
  final Value<int?> trackCount;
  final Value<String?> platform;
  final Value<String?> isbn;
  final Value<int> progress;
  final Value<int?> totalProgress;
  final Value<String?> notes;
  final Value<String?> franchiseId;
  final Value<String?> externalSource;
  final Value<String?> externalId;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> finishedAt;
  final Value<DateTime> addedAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MediaItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.originalTitle = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.status = const Value.absent(),
    this.description = const Value.absent(),
    this.creators = const Value.absent(),
    this.coverUrl = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.rating = const Value.absent(),
    this.pageCount = const Value.absent(),
    this.chapterCount = const Value.absent(),
    this.episodeCount = const Value.absent(),
    this.runtimeMinutes = const Value.absent(),
    this.trackCount = const Value.absent(),
    this.platform = const Value.absent(),
    this.isbn = const Value.absent(),
    this.progress = const Value.absent(),
    this.totalProgress = const Value.absent(),
    this.notes = const Value.absent(),
    this.franchiseId = const Value.absent(),
    this.externalSource = const Value.absent(),
    this.externalId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MediaItemsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.originalTitle = const Value.absent(),
    required MediaType mediaType,
    this.status = const Value.absent(),
    this.description = const Value.absent(),
    this.creators = const Value.absent(),
    this.coverUrl = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.rating = const Value.absent(),
    this.pageCount = const Value.absent(),
    this.chapterCount = const Value.absent(),
    this.episodeCount = const Value.absent(),
    this.runtimeMinutes = const Value.absent(),
    this.trackCount = const Value.absent(),
    this.platform = const Value.absent(),
    this.isbn = const Value.absent(),
    this.progress = const Value.absent(),
    this.totalProgress = const Value.absent(),
    this.notes = const Value.absent(),
    this.franchiseId = const Value.absent(),
    this.externalSource = const Value.absent(),
    this.externalId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : title = Value(title),
       mediaType = Value(mediaType);
  static Insertable<MediaItem> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? originalTitle,
    Expression<String>? mediaType,
    Expression<String>? status,
    Expression<String>? description,
    Expression<String>? creators,
    Expression<String>? coverUrl,
    Expression<DateTime>? releaseDate,
    Expression<double>? rating,
    Expression<int>? pageCount,
    Expression<int>? chapterCount,
    Expression<int>? episodeCount,
    Expression<int>? runtimeMinutes,
    Expression<int>? trackCount,
    Expression<String>? platform,
    Expression<String>? isbn,
    Expression<int>? progress,
    Expression<int>? totalProgress,
    Expression<String>? notes,
    Expression<String>? franchiseId,
    Expression<String>? externalSource,
    Expression<String>? externalId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? finishedAt,
    Expression<DateTime>? addedAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (originalTitle != null) 'original_title': originalTitle,
      if (mediaType != null) 'media_type': mediaType,
      if (status != null) 'status': status,
      if (description != null) 'description': description,
      if (creators != null) 'creators': creators,
      if (coverUrl != null) 'cover_url': coverUrl,
      if (releaseDate != null) 'release_date': releaseDate,
      if (rating != null) 'rating': rating,
      if (pageCount != null) 'page_count': pageCount,
      if (chapterCount != null) 'chapter_count': chapterCount,
      if (episodeCount != null) 'episode_count': episodeCount,
      if (runtimeMinutes != null) 'runtime_minutes': runtimeMinutes,
      if (trackCount != null) 'track_count': trackCount,
      if (platform != null) 'platform': platform,
      if (isbn != null) 'isbn': isbn,
      if (progress != null) 'progress': progress,
      if (totalProgress != null) 'total_progress': totalProgress,
      if (notes != null) 'notes': notes,
      if (franchiseId != null) 'franchise_id': franchiseId,
      if (externalSource != null) 'external_source': externalSource,
      if (externalId != null) 'external_id': externalId,
      if (startedAt != null) 'started_at': startedAt,
      if (finishedAt != null) 'finished_at': finishedAt,
      if (addedAt != null) 'added_at': addedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MediaItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? originalTitle,
    Value<MediaType>? mediaType,
    Value<MediaStatus>? status,
    Value<String?>? description,
    Value<String?>? creators,
    Value<String?>? coverUrl,
    Value<DateTime?>? releaseDate,
    Value<double?>? rating,
    Value<int?>? pageCount,
    Value<int?>? chapterCount,
    Value<int?>? episodeCount,
    Value<int?>? runtimeMinutes,
    Value<int?>? trackCount,
    Value<String?>? platform,
    Value<String?>? isbn,
    Value<int>? progress,
    Value<int?>? totalProgress,
    Value<String?>? notes,
    Value<String?>? franchiseId,
    Value<String?>? externalSource,
    Value<String?>? externalId,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? finishedAt,
    Value<DateTime>? addedAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MediaItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      originalTitle: originalTitle ?? this.originalTitle,
      mediaType: mediaType ?? this.mediaType,
      status: status ?? this.status,
      description: description ?? this.description,
      creators: creators ?? this.creators,
      coverUrl: coverUrl ?? this.coverUrl,
      releaseDate: releaseDate ?? this.releaseDate,
      rating: rating ?? this.rating,
      pageCount: pageCount ?? this.pageCount,
      chapterCount: chapterCount ?? this.chapterCount,
      episodeCount: episodeCount ?? this.episodeCount,
      runtimeMinutes: runtimeMinutes ?? this.runtimeMinutes,
      trackCount: trackCount ?? this.trackCount,
      platform: platform ?? this.platform,
      isbn: isbn ?? this.isbn,
      progress: progress ?? this.progress,
      totalProgress: totalProgress ?? this.totalProgress,
      notes: notes ?? this.notes,
      franchiseId: franchiseId ?? this.franchiseId,
      externalSource: externalSource ?? this.externalSource,
      externalId: externalId ?? this.externalId,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      addedAt: addedAt ?? this.addedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (originalTitle.present) {
      map['original_title'] = Variable<String>(originalTitle.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<String>(
        $MediaItemsTable.$convertermediaType.toSql(mediaType.value),
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $MediaItemsTable.$converterstatus.toSql(status.value),
      );
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (creators.present) {
      map['creators'] = Variable<String>(creators.value);
    }
    if (coverUrl.present) {
      map['cover_url'] = Variable<String>(coverUrl.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<DateTime>(releaseDate.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (pageCount.present) {
      map['page_count'] = Variable<int>(pageCount.value);
    }
    if (chapterCount.present) {
      map['chapter_count'] = Variable<int>(chapterCount.value);
    }
    if (episodeCount.present) {
      map['episode_count'] = Variable<int>(episodeCount.value);
    }
    if (runtimeMinutes.present) {
      map['runtime_minutes'] = Variable<int>(runtimeMinutes.value);
    }
    if (trackCount.present) {
      map['track_count'] = Variable<int>(trackCount.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    if (isbn.present) {
      map['isbn'] = Variable<String>(isbn.value);
    }
    if (progress.present) {
      map['progress'] = Variable<int>(progress.value);
    }
    if (totalProgress.present) {
      map['total_progress'] = Variable<int>(totalProgress.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (franchiseId.present) {
      map['franchise_id'] = Variable<String>(franchiseId.value);
    }
    if (externalSource.present) {
      map['external_source'] = Variable<String>(externalSource.value);
    }
    if (externalId.present) {
      map['external_id'] = Variable<String>(externalId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (finishedAt.present) {
      map['finished_at'] = Variable<DateTime>(finishedAt.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('originalTitle: $originalTitle, ')
          ..write('mediaType: $mediaType, ')
          ..write('status: $status, ')
          ..write('description: $description, ')
          ..write('creators: $creators, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('rating: $rating, ')
          ..write('pageCount: $pageCount, ')
          ..write('chapterCount: $chapterCount, ')
          ..write('episodeCount: $episodeCount, ')
          ..write('runtimeMinutes: $runtimeMinutes, ')
          ..write('trackCount: $trackCount, ')
          ..write('platform: $platform, ')
          ..write('isbn: $isbn, ')
          ..write('progress: $progress, ')
          ..write('totalProgress: $totalProgress, ')
          ..write('notes: $notes, ')
          ..write('franchiseId: $franchiseId, ')
          ..write('externalSource: $externalSource, ')
          ..write('externalId: $externalId, ')
          ..write('startedAt: $startedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('addedAt: $addedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WatchOrdersTable extends WatchOrders
    with TableInfo<$WatchOrdersTable, WatchOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WatchOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => uuidGenerator.v4(),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 300,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _franchiseIdMeta = const VerificationMeta(
    'franchiseId',
  );
  @override
  late final GeneratedColumn<String> franchiseId = GeneratedColumn<String>(
    'franchise_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES franchises (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _isUserCreatedMeta = const VerificationMeta(
    'isUserCreated',
  );
  @override
  late final GeneratedColumn<bool> isUserCreated = GeneratedColumn<bool>(
    'is_user_created',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_user_created" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    author,
    franchiseId,
    isUserCreated,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'watch_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<WatchOrder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('franchise_id')) {
      context.handle(
        _franchiseIdMeta,
        franchiseId.isAcceptableOrUnknown(
          data['franchise_id']!,
          _franchiseIdMeta,
        ),
      );
    }
    if (data.containsKey('is_user_created')) {
      context.handle(
        _isUserCreatedMeta,
        isUserCreated.isAcceptableOrUnknown(
          data['is_user_created']!,
          _isUserCreatedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WatchOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WatchOrder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      franchiseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}franchise_id'],
      ),
      isUserCreated: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_user_created'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WatchOrdersTable createAlias(String alias) {
    return $WatchOrdersTable(attachedDatabase, alias);
  }
}

class WatchOrder extends DataClass implements Insertable<WatchOrder> {
  final String id;
  final String name;
  final String? description;
  final String? author;

  /// The franchise this order applies to, if it is tied to one.
  final String? franchiseId;

  /// Whether the user authored this order locally.
  final bool isUserCreated;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WatchOrder({
    required this.id,
    required this.name,
    this.description,
    this.author,
    this.franchiseId,
    required this.isUserCreated,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || franchiseId != null) {
      map['franchise_id'] = Variable<String>(franchiseId);
    }
    map['is_user_created'] = Variable<bool>(isUserCreated);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WatchOrdersCompanion toCompanion(bool nullToAbsent) {
    return WatchOrdersCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      franchiseId: franchiseId == null && nullToAbsent
          ? const Value.absent()
          : Value(franchiseId),
      isUserCreated: Value(isUserCreated),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WatchOrder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WatchOrder(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      author: serializer.fromJson<String?>(json['author']),
      franchiseId: serializer.fromJson<String?>(json['franchiseId']),
      isUserCreated: serializer.fromJson<bool>(json['isUserCreated']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'author': serializer.toJson<String?>(author),
      'franchiseId': serializer.toJson<String?>(franchiseId),
      'isUserCreated': serializer.toJson<bool>(isUserCreated),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WatchOrder copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> author = const Value.absent(),
    Value<String?> franchiseId = const Value.absent(),
    bool? isUserCreated,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => WatchOrder(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    author: author.present ? author.value : this.author,
    franchiseId: franchiseId.present ? franchiseId.value : this.franchiseId,
    isUserCreated: isUserCreated ?? this.isUserCreated,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WatchOrder copyWithCompanion(WatchOrdersCompanion data) {
    return WatchOrder(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      author: data.author.present ? data.author.value : this.author,
      franchiseId: data.franchiseId.present
          ? data.franchiseId.value
          : this.franchiseId,
      isUserCreated: data.isUserCreated.present
          ? data.isUserCreated.value
          : this.isUserCreated,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WatchOrder(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('author: $author, ')
          ..write('franchiseId: $franchiseId, ')
          ..write('isUserCreated: $isUserCreated, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    author,
    franchiseId,
    isUserCreated,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WatchOrder &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.author == this.author &&
          other.franchiseId == this.franchiseId &&
          other.isUserCreated == this.isUserCreated &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WatchOrdersCompanion extends UpdateCompanion<WatchOrder> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> author;
  final Value<String?> franchiseId;
  final Value<bool> isUserCreated;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WatchOrdersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.author = const Value.absent(),
    this.franchiseId = const Value.absent(),
    this.isUserCreated = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WatchOrdersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.author = const Value.absent(),
    this.franchiseId = const Value.absent(),
    this.isUserCreated = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<WatchOrder> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? author,
    Expression<String>? franchiseId,
    Expression<bool>? isUserCreated,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (author != null) 'author': author,
      if (franchiseId != null) 'franchise_id': franchiseId,
      if (isUserCreated != null) 'is_user_created': isUserCreated,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WatchOrdersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? author,
    Value<String?>? franchiseId,
    Value<bool>? isUserCreated,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return WatchOrdersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      author: author ?? this.author,
      franchiseId: franchiseId ?? this.franchiseId,
      isUserCreated: isUserCreated ?? this.isUserCreated,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (franchiseId.present) {
      map['franchise_id'] = Variable<String>(franchiseId.value);
    }
    if (isUserCreated.present) {
      map['is_user_created'] = Variable<bool>(isUserCreated.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WatchOrdersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('author: $author, ')
          ..write('franchiseId: $franchiseId, ')
          ..write('isUserCreated: $isUserCreated, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WatchOrderStepsTable extends WatchOrderSteps
    with TableInfo<$WatchOrderStepsTable, WatchOrderStep> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WatchOrderStepsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => uuidGenerator.v4(),
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES watch_orders (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mediaItemIdMeta = const VerificationMeta(
    'mediaItemId',
  );
  @override
  late final GeneratedColumn<String> mediaItemId = GeneratedColumn<String>(
    'media_item_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES media_items (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 500,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderId,
    position,
    mediaItemId,
    title,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'watch_order_steps';
  @override
  VerificationContext validateIntegrity(
    Insertable<WatchOrderStep> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('media_item_id')) {
      context.handle(
        _mediaItemIdMeta,
        mediaItemId.isAcceptableOrUnknown(
          data['media_item_id']!,
          _mediaItemIdMeta,
        ),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WatchOrderStep map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WatchOrderStep(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      mediaItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_item_id'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $WatchOrderStepsTable createAlias(String alias) {
    return $WatchOrderStepsTable(attachedDatabase, alias);
  }
}

class WatchOrderStep extends DataClass implements Insertable<WatchOrderStep> {
  final String id;
  final String orderId;

  /// Zero-based position within the order.
  final int position;

  /// The library entry this step refers to, if it has been added.
  final String? mediaItemId;

  /// The title of the work, kept even when it is not in the library yet.
  final String title;
  final String? note;
  const WatchOrderStep({
    required this.id,
    required this.orderId,
    required this.position,
    this.mediaItemId,
    required this.title,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['order_id'] = Variable<String>(orderId);
    map['position'] = Variable<int>(position);
    if (!nullToAbsent || mediaItemId != null) {
      map['media_item_id'] = Variable<String>(mediaItemId);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  WatchOrderStepsCompanion toCompanion(bool nullToAbsent) {
    return WatchOrderStepsCompanion(
      id: Value(id),
      orderId: Value(orderId),
      position: Value(position),
      mediaItemId: mediaItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaItemId),
      title: Value(title),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory WatchOrderStep.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WatchOrderStep(
      id: serializer.fromJson<String>(json['id']),
      orderId: serializer.fromJson<String>(json['orderId']),
      position: serializer.fromJson<int>(json['position']),
      mediaItemId: serializer.fromJson<String?>(json['mediaItemId']),
      title: serializer.fromJson<String>(json['title']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'orderId': serializer.toJson<String>(orderId),
      'position': serializer.toJson<int>(position),
      'mediaItemId': serializer.toJson<String?>(mediaItemId),
      'title': serializer.toJson<String>(title),
      'note': serializer.toJson<String?>(note),
    };
  }

  WatchOrderStep copyWith({
    String? id,
    String? orderId,
    int? position,
    Value<String?> mediaItemId = const Value.absent(),
    String? title,
    Value<String?> note = const Value.absent(),
  }) => WatchOrderStep(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    position: position ?? this.position,
    mediaItemId: mediaItemId.present ? mediaItemId.value : this.mediaItemId,
    title: title ?? this.title,
    note: note.present ? note.value : this.note,
  );
  WatchOrderStep copyWithCompanion(WatchOrderStepsCompanion data) {
    return WatchOrderStep(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      position: data.position.present ? data.position.value : this.position,
      mediaItemId: data.mediaItemId.present
          ? data.mediaItemId.value
          : this.mediaItemId,
      title: data.title.present ? data.title.value : this.title,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WatchOrderStep(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('position: $position, ')
          ..write('mediaItemId: $mediaItemId, ')
          ..write('title: $title, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, orderId, position, mediaItemId, title, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WatchOrderStep &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.position == this.position &&
          other.mediaItemId == this.mediaItemId &&
          other.title == this.title &&
          other.note == this.note);
}

class WatchOrderStepsCompanion extends UpdateCompanion<WatchOrderStep> {
  final Value<String> id;
  final Value<String> orderId;
  final Value<int> position;
  final Value<String?> mediaItemId;
  final Value<String> title;
  final Value<String?> note;
  final Value<int> rowid;
  const WatchOrderStepsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.position = const Value.absent(),
    this.mediaItemId = const Value.absent(),
    this.title = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WatchOrderStepsCompanion.insert({
    this.id = const Value.absent(),
    required String orderId,
    required int position,
    this.mediaItemId = const Value.absent(),
    required String title,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : orderId = Value(orderId),
       position = Value(position),
       title = Value(title);
  static Insertable<WatchOrderStep> custom({
    Expression<String>? id,
    Expression<String>? orderId,
    Expression<int>? position,
    Expression<String>? mediaItemId,
    Expression<String>? title,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (position != null) 'position': position,
      if (mediaItemId != null) 'media_item_id': mediaItemId,
      if (title != null) 'title': title,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WatchOrderStepsCompanion copyWith({
    Value<String>? id,
    Value<String>? orderId,
    Value<int>? position,
    Value<String?>? mediaItemId,
    Value<String>? title,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return WatchOrderStepsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      position: position ?? this.position,
      mediaItemId: mediaItemId ?? this.mediaItemId,
      title: title ?? this.title,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (mediaItemId.present) {
      map['media_item_id'] = Variable<String>(mediaItemId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WatchOrderStepsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('position: $position, ')
          ..write('mediaItemId: $mediaItemId, ')
          ..write('title: $title, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HistoryEntriesTable extends HistoryEntries
    with TableInfo<$HistoryEntriesTable, HistoryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoryEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => uuidGenerator.v4(),
  );
  static const VerificationMeta _mediaItemIdMeta = const VerificationMeta(
    'mediaItemId',
  );
  @override
  late final GeneratedColumn<String> mediaItemId = GeneratedColumn<String>(
    'media_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES media_items (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<HistoryEventType, String>
  eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<HistoryEventType>($HistoryEntriesTable.$convertereventType);
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<int> progress = GeneratedColumn<int>(
    'progress',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
    'rating',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mediaItemId,
    eventType,
    occurredAt,
    progress,
    rating,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'history_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<HistoryEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('media_item_id')) {
      context.handle(
        _mediaItemIdMeta,
        mediaItemId.isAcceptableOrUnknown(
          data['media_item_id']!,
          _mediaItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mediaItemIdMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistoryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistoryEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      mediaItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_item_id'],
      )!,
      eventType: $HistoryEntriesTable.$convertereventType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}event_type'],
        )!,
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}progress'],
      ),
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $HistoryEntriesTable createAlias(String alias) {
    return $HistoryEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<HistoryEventType, String, String>
  $convertereventType = const EnumNameConverter<HistoryEventType>(
    HistoryEventType.values,
  );
}

class HistoryEntry extends DataClass implements Insertable<HistoryEntry> {
  final String id;
  final String mediaItemId;
  final HistoryEventType eventType;
  final DateTime occurredAt;
  final int? progress;
  final double? rating;
  final String? note;
  const HistoryEntry({
    required this.id,
    required this.mediaItemId,
    required this.eventType,
    required this.occurredAt,
    this.progress,
    this.rating,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['media_item_id'] = Variable<String>(mediaItemId);
    {
      map['event_type'] = Variable<String>(
        $HistoryEntriesTable.$convertereventType.toSql(eventType),
      );
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    if (!nullToAbsent || progress != null) {
      map['progress'] = Variable<int>(progress);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<double>(rating);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  HistoryEntriesCompanion toCompanion(bool nullToAbsent) {
    return HistoryEntriesCompanion(
      id: Value(id),
      mediaItemId: Value(mediaItemId),
      eventType: Value(eventType),
      occurredAt: Value(occurredAt),
      progress: progress == null && nullToAbsent
          ? const Value.absent()
          : Value(progress),
      rating: rating == null && nullToAbsent
          ? const Value.absent()
          : Value(rating),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory HistoryEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistoryEntry(
      id: serializer.fromJson<String>(json['id']),
      mediaItemId: serializer.fromJson<String>(json['mediaItemId']),
      eventType: $HistoryEntriesTable.$convertereventType.fromJson(
        serializer.fromJson<String>(json['eventType']),
      ),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      progress: serializer.fromJson<int?>(json['progress']),
      rating: serializer.fromJson<double?>(json['rating']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'mediaItemId': serializer.toJson<String>(mediaItemId),
      'eventType': serializer.toJson<String>(
        $HistoryEntriesTable.$convertereventType.toJson(eventType),
      ),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'progress': serializer.toJson<int?>(progress),
      'rating': serializer.toJson<double?>(rating),
      'note': serializer.toJson<String?>(note),
    };
  }

  HistoryEntry copyWith({
    String? id,
    String? mediaItemId,
    HistoryEventType? eventType,
    DateTime? occurredAt,
    Value<int?> progress = const Value.absent(),
    Value<double?> rating = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => HistoryEntry(
    id: id ?? this.id,
    mediaItemId: mediaItemId ?? this.mediaItemId,
    eventType: eventType ?? this.eventType,
    occurredAt: occurredAt ?? this.occurredAt,
    progress: progress.present ? progress.value : this.progress,
    rating: rating.present ? rating.value : this.rating,
    note: note.present ? note.value : this.note,
  );
  HistoryEntry copyWithCompanion(HistoryEntriesCompanion data) {
    return HistoryEntry(
      id: data.id.present ? data.id.value : this.id,
      mediaItemId: data.mediaItemId.present
          ? data.mediaItemId.value
          : this.mediaItemId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      progress: data.progress.present ? data.progress.value : this.progress,
      rating: data.rating.present ? data.rating.value : this.rating,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistoryEntry(')
          ..write('id: $id, ')
          ..write('mediaItemId: $mediaItemId, ')
          ..write('eventType: $eventType, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('progress: $progress, ')
          ..write('rating: $rating, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mediaItemId,
    eventType,
    occurredAt,
    progress,
    rating,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryEntry &&
          other.id == this.id &&
          other.mediaItemId == this.mediaItemId &&
          other.eventType == this.eventType &&
          other.occurredAt == this.occurredAt &&
          other.progress == this.progress &&
          other.rating == this.rating &&
          other.note == this.note);
}

class HistoryEntriesCompanion extends UpdateCompanion<HistoryEntry> {
  final Value<String> id;
  final Value<String> mediaItemId;
  final Value<HistoryEventType> eventType;
  final Value<DateTime> occurredAt;
  final Value<int?> progress;
  final Value<double?> rating;
  final Value<String?> note;
  final Value<int> rowid;
  const HistoryEntriesCompanion({
    this.id = const Value.absent(),
    this.mediaItemId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.progress = const Value.absent(),
    this.rating = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HistoryEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String mediaItemId,
    required HistoryEventType eventType,
    this.occurredAt = const Value.absent(),
    this.progress = const Value.absent(),
    this.rating = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : mediaItemId = Value(mediaItemId),
       eventType = Value(eventType);
  static Insertable<HistoryEntry> custom({
    Expression<String>? id,
    Expression<String>? mediaItemId,
    Expression<String>? eventType,
    Expression<DateTime>? occurredAt,
    Expression<int>? progress,
    Expression<double>? rating,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mediaItemId != null) 'media_item_id': mediaItemId,
      if (eventType != null) 'event_type': eventType,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (progress != null) 'progress': progress,
      if (rating != null) 'rating': rating,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HistoryEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? mediaItemId,
    Value<HistoryEventType>? eventType,
    Value<DateTime>? occurredAt,
    Value<int?>? progress,
    Value<double?>? rating,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return HistoryEntriesCompanion(
      id: id ?? this.id,
      mediaItemId: mediaItemId ?? this.mediaItemId,
      eventType: eventType ?? this.eventType,
      occurredAt: occurredAt ?? this.occurredAt,
      progress: progress ?? this.progress,
      rating: rating ?? this.rating,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (mediaItemId.present) {
      map['media_item_id'] = Variable<String>(mediaItemId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(
        $HistoryEntriesTable.$convertereventType.toSql(eventType.value),
      );
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (progress.present) {
      map['progress'] = Variable<int>(progress.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('mediaItemId: $mediaItemId, ')
          ..write('eventType: $eventType, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('progress: $progress, ')
          ..write('rating: $rating, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MetadataCacheEntriesTable extends MetadataCacheEntries
    with TableInfo<$MetadataCacheEntriesTable, MetadataCacheEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetadataCacheEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => uuidGenerator.v4(),
  );
  static const VerificationMeta _mediaItemIdMeta = const VerificationMeta(
    'mediaItemId',
  );
  @override
  late final GeneratedColumn<String> mediaItemId = GeneratedColumn<String>(
    'media_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES media_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _externalIdMeta = const VerificationMeta(
    'externalId',
  );
  @override
  late final GeneratedColumn<String> externalId = GeneratedColumn<String>(
    'external_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mediaItemId,
    source,
    externalId,
    payload,
    fetchedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'metadata_cache_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<MetadataCacheEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('media_item_id')) {
      context.handle(
        _mediaItemIdMeta,
        mediaItemId.isAcceptableOrUnknown(
          data['media_item_id']!,
          _mediaItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mediaItemIdMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('external_id')) {
      context.handle(
        _externalIdMeta,
        externalId.isAcceptableOrUnknown(data['external_id']!, _externalIdMeta),
      );
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MetadataCacheEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetadataCacheEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      mediaItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_item_id'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      externalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_id'],
      ),
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $MetadataCacheEntriesTable createAlias(String alias) {
    return $MetadataCacheEntriesTable(attachedDatabase, alias);
  }
}

class MetadataCacheEntry extends DataClass
    implements Insertable<MetadataCacheEntry> {
  final String id;
  final String mediaItemId;

  /// The provider the data came from, e.g. `anilist` or `tmdb`.
  final String source;

  /// The provider-specific identifier the data was fetched with.
  final String? externalId;

  /// The raw JSON payload, stored verbatim so it can be re-parsed later.
  final String payload;
  final DateTime fetchedAt;
  const MetadataCacheEntry({
    required this.id,
    required this.mediaItemId,
    required this.source,
    this.externalId,
    required this.payload,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['media_item_id'] = Variable<String>(mediaItemId);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || externalId != null) {
      map['external_id'] = Variable<String>(externalId);
    }
    map['payload'] = Variable<String>(payload);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  MetadataCacheEntriesCompanion toCompanion(bool nullToAbsent) {
    return MetadataCacheEntriesCompanion(
      id: Value(id),
      mediaItemId: Value(mediaItemId),
      source: Value(source),
      externalId: externalId == null && nullToAbsent
          ? const Value.absent()
          : Value(externalId),
      payload: Value(payload),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory MetadataCacheEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetadataCacheEntry(
      id: serializer.fromJson<String>(json['id']),
      mediaItemId: serializer.fromJson<String>(json['mediaItemId']),
      source: serializer.fromJson<String>(json['source']),
      externalId: serializer.fromJson<String?>(json['externalId']),
      payload: serializer.fromJson<String>(json['payload']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'mediaItemId': serializer.toJson<String>(mediaItemId),
      'source': serializer.toJson<String>(source),
      'externalId': serializer.toJson<String?>(externalId),
      'payload': serializer.toJson<String>(payload),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  MetadataCacheEntry copyWith({
    String? id,
    String? mediaItemId,
    String? source,
    Value<String?> externalId = const Value.absent(),
    String? payload,
    DateTime? fetchedAt,
  }) => MetadataCacheEntry(
    id: id ?? this.id,
    mediaItemId: mediaItemId ?? this.mediaItemId,
    source: source ?? this.source,
    externalId: externalId.present ? externalId.value : this.externalId,
    payload: payload ?? this.payload,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  MetadataCacheEntry copyWithCompanion(MetadataCacheEntriesCompanion data) {
    return MetadataCacheEntry(
      id: data.id.present ? data.id.value : this.id,
      mediaItemId: data.mediaItemId.present
          ? data.mediaItemId.value
          : this.mediaItemId,
      source: data.source.present ? data.source.value : this.source,
      externalId: data.externalId.present
          ? data.externalId.value
          : this.externalId,
      payload: data.payload.present ? data.payload.value : this.payload,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetadataCacheEntry(')
          ..write('id: $id, ')
          ..write('mediaItemId: $mediaItemId, ')
          ..write('source: $source, ')
          ..write('externalId: $externalId, ')
          ..write('payload: $payload, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, mediaItemId, source, externalId, payload, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetadataCacheEntry &&
          other.id == this.id &&
          other.mediaItemId == this.mediaItemId &&
          other.source == this.source &&
          other.externalId == this.externalId &&
          other.payload == this.payload &&
          other.fetchedAt == this.fetchedAt);
}

class MetadataCacheEntriesCompanion
    extends UpdateCompanion<MetadataCacheEntry> {
  final Value<String> id;
  final Value<String> mediaItemId;
  final Value<String> source;
  final Value<String?> externalId;
  final Value<String> payload;
  final Value<DateTime> fetchedAt;
  final Value<int> rowid;
  const MetadataCacheEntriesCompanion({
    this.id = const Value.absent(),
    this.mediaItemId = const Value.absent(),
    this.source = const Value.absent(),
    this.externalId = const Value.absent(),
    this.payload = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MetadataCacheEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String mediaItemId,
    required String source,
    this.externalId = const Value.absent(),
    required String payload,
    this.fetchedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : mediaItemId = Value(mediaItemId),
       source = Value(source),
       payload = Value(payload);
  static Insertable<MetadataCacheEntry> custom({
    Expression<String>? id,
    Expression<String>? mediaItemId,
    Expression<String>? source,
    Expression<String>? externalId,
    Expression<String>? payload,
    Expression<DateTime>? fetchedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mediaItemId != null) 'media_item_id': mediaItemId,
      if (source != null) 'source': source,
      if (externalId != null) 'external_id': externalId,
      if (payload != null) 'payload': payload,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MetadataCacheEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? mediaItemId,
    Value<String>? source,
    Value<String?>? externalId,
    Value<String>? payload,
    Value<DateTime>? fetchedAt,
    Value<int>? rowid,
  }) {
    return MetadataCacheEntriesCompanion(
      id: id ?? this.id,
      mediaItemId: mediaItemId ?? this.mediaItemId,
      source: source ?? this.source,
      externalId: externalId ?? this.externalId,
      payload: payload ?? this.payload,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (mediaItemId.present) {
      map['media_item_id'] = Variable<String>(mediaItemId.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (externalId.present) {
      map['external_id'] = Variable<String>(externalId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetadataCacheEntriesCompanion(')
          ..write('id: $id, ')
          ..write('mediaItemId: $mediaItemId, ')
          ..write('source: $source, ')
          ..write('externalId: $externalId, ')
          ..write('payload: $payload, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => uuidGenerator.v4(),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final String id;
  final String name;
  const Tag({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(id: Value(id), name: Value(name));
  }

  factory Tag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Tag copyWith({String? id, String? name}) =>
      Tag(id: id ?? this.id, name: name ?? this.name);
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag && other.id == this.id && other.name == this.name);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Tag> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? rowid,
  }) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MediaItemTagsTable extends MediaItemTags
    with TableInfo<$MediaItemTagsTable, MediaItemTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaItemTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mediaItemIdMeta = const VerificationMeta(
    'mediaItemId',
  );
  @override
  late final GeneratedColumn<String> mediaItemId = GeneratedColumn<String>(
    'media_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES media_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [mediaItemId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_item_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<MediaItemTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('media_item_id')) {
      context.handle(
        _mediaItemIdMeta,
        mediaItemId.isAcceptableOrUnknown(
          data['media_item_id']!,
          _mediaItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mediaItemIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {mediaItemId, tagId};
  @override
  MediaItemTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaItemTag(
      mediaItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_item_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $MediaItemTagsTable createAlias(String alias) {
    return $MediaItemTagsTable(attachedDatabase, alias);
  }
}

class MediaItemTag extends DataClass implements Insertable<MediaItemTag> {
  final String mediaItemId;
  final String tagId;
  const MediaItemTag({required this.mediaItemId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['media_item_id'] = Variable<String>(mediaItemId);
    map['tag_id'] = Variable<String>(tagId);
    return map;
  }

  MediaItemTagsCompanion toCompanion(bool nullToAbsent) {
    return MediaItemTagsCompanion(
      mediaItemId: Value(mediaItemId),
      tagId: Value(tagId),
    );
  }

  factory MediaItemTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaItemTag(
      mediaItemId: serializer.fromJson<String>(json['mediaItemId']),
      tagId: serializer.fromJson<String>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mediaItemId': serializer.toJson<String>(mediaItemId),
      'tagId': serializer.toJson<String>(tagId),
    };
  }

  MediaItemTag copyWith({String? mediaItemId, String? tagId}) => MediaItemTag(
    mediaItemId: mediaItemId ?? this.mediaItemId,
    tagId: tagId ?? this.tagId,
  );
  MediaItemTag copyWithCompanion(MediaItemTagsCompanion data) {
    return MediaItemTag(
      mediaItemId: data.mediaItemId.present
          ? data.mediaItemId.value
          : this.mediaItemId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaItemTag(')
          ..write('mediaItemId: $mediaItemId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(mediaItemId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaItemTag &&
          other.mediaItemId == this.mediaItemId &&
          other.tagId == this.tagId);
}

class MediaItemTagsCompanion extends UpdateCompanion<MediaItemTag> {
  final Value<String> mediaItemId;
  final Value<String> tagId;
  final Value<int> rowid;
  const MediaItemTagsCompanion({
    this.mediaItemId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MediaItemTagsCompanion.insert({
    required String mediaItemId,
    required String tagId,
    this.rowid = const Value.absent(),
  }) : mediaItemId = Value(mediaItemId),
       tagId = Value(tagId);
  static Insertable<MediaItemTag> custom({
    Expression<String>? mediaItemId,
    Expression<String>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (mediaItemId != null) 'media_item_id': mediaItemId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MediaItemTagsCompanion copyWith({
    Value<String>? mediaItemId,
    Value<String>? tagId,
    Value<int>? rowid,
  }) {
    return MediaItemTagsCompanion(
      mediaItemId: mediaItemId ?? this.mediaItemId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mediaItemId.present) {
      map['media_item_id'] = Variable<String>(mediaItemId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaItemTagsCompanion(')
          ..write('mediaItemId: $mediaItemId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: DateTime.now,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const AppSetting({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSetting copyWith({String? key, String? value, DateTime? updatedAt}) =>
      AppSetting(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FranchisesTable franchises = $FranchisesTable(this);
  late final $MediaItemsTable mediaItems = $MediaItemsTable(this);
  late final $WatchOrdersTable watchOrders = $WatchOrdersTable(this);
  late final $WatchOrderStepsTable watchOrderSteps = $WatchOrderStepsTable(
    this,
  );
  late final $HistoryEntriesTable historyEntries = $HistoryEntriesTable(this);
  late final $MetadataCacheEntriesTable metadataCacheEntries =
      $MetadataCacheEntriesTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $MediaItemTagsTable mediaItemTags = $MediaItemTagsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final MediaItemDao mediaItemDao = MediaItemDao(this as AppDatabase);
  late final FranchiseDao franchiseDao = FranchiseDao(this as AppDatabase);
  late final WatchOrderDao watchOrderDao = WatchOrderDao(this as AppDatabase);
  late final HistoryDao historyDao = HistoryDao(this as AppDatabase);
  late final MetadataCacheDao metadataCacheDao = MetadataCacheDao(
    this as AppDatabase,
  );
  late final TagDao tagDao = TagDao(this as AppDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    franchises,
    mediaItems,
    watchOrders,
    watchOrderSteps,
    historyEntries,
    metadataCacheEntries,
    tags,
    mediaItemTags,
    appSettings,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'franchises',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('media_items', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'franchises',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('watch_orders', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'watch_orders',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('watch_order_steps', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'media_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('watch_order_steps', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'media_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('history_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'media_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('metadata_cache_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'media_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('media_item_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tags',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('media_item_tags', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$FranchisesTableCreateCompanionBuilder = FranchisesCompanion Function({
  Value<String> id,
  required String name,
  Value<String?> description,
  Value<MediaType?> mediaType,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$FranchisesTableUpdateCompanionBuilder = FranchisesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> description,
  Value<MediaType?> mediaType,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$FranchisesTableReferences
    extends BaseReferences<_$AppDatabase, $FranchisesTable, Franchise> {
  $$FranchisesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MediaItemsTable, List<MediaItem>>
  _mediaItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mediaItems,
    aliasName: 'franchises__id__media_items__franchise_id',
  );

  $$MediaItemsTableProcessedTableManager get mediaItemsRefs {
    final manager = $$MediaItemsTableTableManager(
      $_db,
      $_db.mediaItems,
    ).filter((f) => f.franchiseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_mediaItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WatchOrdersTable, List<WatchOrder>>
  _watchOrdersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.watchOrders,
    aliasName: 'franchises__id__watch_orders__franchise_id',
  );

  $$WatchOrdersTableProcessedTableManager get watchOrdersRefs {
    final manager = $$WatchOrdersTableTableManager(
      $_db,
      $_db.watchOrders,
    ).filter((f) => f.franchiseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_watchOrdersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FranchisesTableFilterComposer
    extends Composer<_$AppDatabase, $FranchisesTable> {
  $$FranchisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MediaType?, MediaType, String> get mediaType =>
      $composableBuilder(
        column: $table.mediaType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> mediaItemsRefs(
    Expression<bool> Function($$MediaItemsTableFilterComposer f) f,
  ) {
    final $$MediaItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.franchiseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableFilterComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> watchOrdersRefs(
    Expression<bool> Function($$WatchOrdersTableFilterComposer f) f,
  ) {
    final $$WatchOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.watchOrders,
      getReferencedColumn: (t) => t.franchiseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WatchOrdersTableFilterComposer(
            $db: $db,
            $table: $db.watchOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FranchisesTableOrderingComposer
    extends Composer<_$AppDatabase, $FranchisesTable> {
  $$FranchisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FranchisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FranchisesTable> {
  $$FranchisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<MediaType?, String> get mediaType =>
      $composableBuilder(column: $table.mediaType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> mediaItemsRefs<T extends Object>(
    Expression<T> Function($$MediaItemsTableAnnotationComposer a) f,
  ) {
    final $$MediaItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.franchiseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> watchOrdersRefs<T extends Object>(
    Expression<T> Function($$WatchOrdersTableAnnotationComposer a) f,
  ) {
    final $$WatchOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.watchOrders,
      getReferencedColumn: (t) => t.franchiseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WatchOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.watchOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FranchisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FranchisesTable,
          Franchise,
          $$FranchisesTableFilterComposer,
          $$FranchisesTableOrderingComposer,
          $$FranchisesTableAnnotationComposer,
          $$FranchisesTableCreateCompanionBuilder,
          $$FranchisesTableUpdateCompanionBuilder,
          (Franchise, $$FranchisesTableReferences),
          Franchise,
          PrefetchHooks Function({bool mediaItemsRefs, bool watchOrdersRefs})
        > {
  $$FranchisesTableTableManager(_$AppDatabase db, $FranchisesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FranchisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FranchisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FranchisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<MediaType?> mediaType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FranchisesCompanion(
                id: id,
                name: name,
                description: description,
                mediaType: mediaType,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<MediaType?> mediaType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FranchisesCompanion.insert(
                id: id,
                name: name,
                description: description,
                mediaType: mediaType,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FranchisesTable, Franchise>(table),
                  $$FranchisesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({mediaItemsRefs = false, watchOrdersRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (mediaItemsRefs) db.mediaItems,
                    if (watchOrdersRefs) db.watchOrders,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (mediaItemsRefs)
                        await $_getPrefetchedData<
                          Franchise,
                          $FranchisesTable,
                          MediaItem
                        >(
                          currentTable: table,
                          referencedTable: $$FranchisesTableReferences
                              ._mediaItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FranchisesTableReferences(
                                db,
                                table,
                                p0,
                              ).mediaItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.franchiseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (watchOrdersRefs)
                        await $_getPrefetchedData<
                          Franchise,
                          $FranchisesTable,
                          WatchOrder
                        >(
                          currentTable: table,
                          referencedTable: $$FranchisesTableReferences
                              ._watchOrdersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FranchisesTableReferences(
                                db,
                                table,
                                p0,
                              ).watchOrdersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.franchiseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FranchisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FranchisesTable,
      Franchise,
      $$FranchisesTableFilterComposer,
      $$FranchisesTableOrderingComposer,
      $$FranchisesTableAnnotationComposer,
      $$FranchisesTableCreateCompanionBuilder,
      $$FranchisesTableUpdateCompanionBuilder,
      (Franchise, $$FranchisesTableReferences),
      Franchise,
      PrefetchHooks Function({bool mediaItemsRefs, bool watchOrdersRefs})
    >;
typedef $$MediaItemsTableCreateCompanionBuilder = MediaItemsCompanion Function({
  Value<String> id,
  required String title,
  Value<String?> originalTitle,
  required MediaType mediaType,
  Value<MediaStatus> status,
  Value<String?> description,
  Value<String?> creators,
  Value<String?> coverUrl,
  Value<DateTime?> releaseDate,
  Value<double?> rating,
  Value<int?> pageCount,
  Value<int?> chapterCount,
  Value<int?> episodeCount,
  Value<int?> runtimeMinutes,
  Value<int?> trackCount,
  Value<String?> platform,
  Value<String?> isbn,
  Value<int> progress,
  Value<int?> totalProgress,
  Value<String?> notes,
  Value<String?> franchiseId,
  Value<String?> externalSource,
  Value<String?> externalId,
  Value<DateTime?> startedAt,
  Value<DateTime?> finishedAt,
  Value<DateTime> addedAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$MediaItemsTableUpdateCompanionBuilder = MediaItemsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> originalTitle,
  Value<MediaType> mediaType,
  Value<MediaStatus> status,
  Value<String?> description,
  Value<String?> creators,
  Value<String?> coverUrl,
  Value<DateTime?> releaseDate,
  Value<double?> rating,
  Value<int?> pageCount,
  Value<int?> chapterCount,
  Value<int?> episodeCount,
  Value<int?> runtimeMinutes,
  Value<int?> trackCount,
  Value<String?> platform,
  Value<String?> isbn,
  Value<int> progress,
  Value<int?> totalProgress,
  Value<String?> notes,
  Value<String?> franchiseId,
  Value<String?> externalSource,
  Value<String?> externalId,
  Value<DateTime?> startedAt,
  Value<DateTime?> finishedAt,
  Value<DateTime> addedAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$MediaItemsTableReferences
    extends BaseReferences<_$AppDatabase, $MediaItemsTable, MediaItem> {
  $$MediaItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FranchisesTable _franchiseIdTable(_$AppDatabase db) =>
      db.franchises.createAlias('media_items__franchise_id__franchises__id');

  $$FranchisesTableProcessedTableManager? get franchiseId {
    final $_column = $_itemColumn<String>('franchise_id');
    if ($_column == null) return null;
    final manager = $$FranchisesTableTableManager(
      $_db,
      $_db.franchises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_franchiseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$WatchOrderStepsTable, List<WatchOrderStep>>
  _watchOrderStepsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.watchOrderSteps,
    aliasName: 'media_items__id__watch_order_steps__media_item_id',
  );

  $$WatchOrderStepsTableProcessedTableManager get watchOrderStepsRefs {
    final manager = $$WatchOrderStepsTableTableManager(
      $_db,
      $_db.watchOrderSteps,
    ).filter((f) => f.mediaItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _watchOrderStepsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HistoryEntriesTable, List<HistoryEntry>>
  _historyEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.historyEntries,
    aliasName: 'media_items__id__history_entries__media_item_id',
  );

  $$HistoryEntriesTableProcessedTableManager get historyEntriesRefs {
    final manager = $$HistoryEntriesTableTableManager(
      $_db,
      $_db.historyEntries,
    ).filter((f) => f.mediaItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_historyEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $MetadataCacheEntriesTable,
    List<MetadataCacheEntry>
  >
  _metadataCacheEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.metadataCacheEntries,
        aliasName: 'media_items__id__metadata_cache_entries__media_item_id',
      );

  $$MetadataCacheEntriesTableProcessedTableManager
  get metadataCacheEntriesRefs {
    final manager = $$MetadataCacheEntriesTableTableManager(
      $_db,
      $_db.metadataCacheEntries,
    ).filter((f) => f.mediaItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _metadataCacheEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MediaItemTagsTable, List<MediaItemTag>>
  _mediaItemTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mediaItemTags,
    aliasName: 'media_items__id__media_item_tags__media_item_id',
  );

  $$MediaItemTagsTableProcessedTableManager get mediaItemTagsRefs {
    final manager = $$MediaItemTagsTableTableManager(
      $_db,
      $_db.mediaItemTags,
    ).filter((f) => f.mediaItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_mediaItemTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MediaItemsTableFilterComposer
    extends Composer<_$AppDatabase, $MediaItemsTable> {
  $$MediaItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MediaType, MediaType, String> get mediaType =>
      $composableBuilder(
        column: $table.mediaType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<MediaStatus, MediaStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creators => $composableBuilder(
    column: $table.creators,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverUrl => $composableBuilder(
    column: $table.coverUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageCount => $composableBuilder(
    column: $table.pageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chapterCount => $composableBuilder(
    column: $table.chapterCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get episodeCount => $composableBuilder(
    column: $table.episodeCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get runtimeMinutes => $composableBuilder(
    column: $table.runtimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get trackCount => $composableBuilder(
    column: $table.trackCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get isbn => $composableBuilder(
    column: $table.isbn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalProgress => $composableBuilder(
    column: $table.totalProgress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalSource => $composableBuilder(
    column: $table.externalSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FranchisesTableFilterComposer get franchiseId {
    final $$FranchisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.franchiseId,
      referencedTable: $db.franchises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FranchisesTableFilterComposer(
            $db: $db,
            $table: $db.franchises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> watchOrderStepsRefs(
    Expression<bool> Function($$WatchOrderStepsTableFilterComposer f) f,
  ) {
    final $$WatchOrderStepsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.watchOrderSteps,
      getReferencedColumn: (t) => t.mediaItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WatchOrderStepsTableFilterComposer(
            $db: $db,
            $table: $db.watchOrderSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> historyEntriesRefs(
    Expression<bool> Function($$HistoryEntriesTableFilterComposer f) f,
  ) {
    final $$HistoryEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.historyEntries,
      getReferencedColumn: (t) => t.mediaItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HistoryEntriesTableFilterComposer(
            $db: $db,
            $table: $db.historyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> metadataCacheEntriesRefs(
    Expression<bool> Function($$MetadataCacheEntriesTableFilterComposer f) f,
  ) {
    final $$MetadataCacheEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.metadataCacheEntries,
      getReferencedColumn: (t) => t.mediaItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetadataCacheEntriesTableFilterComposer(
            $db: $db,
            $table: $db.metadataCacheEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mediaItemTagsRefs(
    Expression<bool> Function($$MediaItemTagsTableFilterComposer f) f,
  ) {
    final $$MediaItemTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mediaItemTags,
      getReferencedColumn: (t) => t.mediaItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemTagsTableFilterComposer(
            $db: $db,
            $table: $db.mediaItemTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MediaItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $MediaItemsTable> {
  $$MediaItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creators => $composableBuilder(
    column: $table.creators,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverUrl => $composableBuilder(
    column: $table.coverUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageCount => $composableBuilder(
    column: $table.pageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chapterCount => $composableBuilder(
    column: $table.chapterCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get episodeCount => $composableBuilder(
    column: $table.episodeCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get runtimeMinutes => $composableBuilder(
    column: $table.runtimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get trackCount => $composableBuilder(
    column: $table.trackCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get isbn => $composableBuilder(
    column: $table.isbn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalProgress => $composableBuilder(
    column: $table.totalProgress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalSource => $composableBuilder(
    column: $table.externalSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FranchisesTableOrderingComposer get franchiseId {
    final $$FranchisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.franchiseId,
      referencedTable: $db.franchises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FranchisesTableOrderingComposer(
            $db: $db,
            $table: $db.franchises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MediaItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MediaItemsTable> {
  $$MediaItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get originalTitle => $composableBuilder(
    column: $table.originalTitle,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<MediaType, String> get mediaType =>
      $composableBuilder(column: $table.mediaType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MediaStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get creators =>
      $composableBuilder(column: $table.creators, builder: (column) => column);

  GeneratedColumn<String> get coverUrl =>
      $composableBuilder(column: $table.coverUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<int> get pageCount =>
      $composableBuilder(column: $table.pageCount, builder: (column) => column);

  GeneratedColumn<int> get chapterCount => $composableBuilder(
    column: $table.chapterCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get episodeCount => $composableBuilder(
    column: $table.episodeCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get runtimeMinutes => $composableBuilder(
    column: $table.runtimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get trackCount => $composableBuilder(
    column: $table.trackCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<String> get isbn =>
      $composableBuilder(column: $table.isbn, builder: (column) => column);

  GeneratedColumn<int> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<int> get totalProgress => $composableBuilder(
    column: $table.totalProgress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get externalSource => $composableBuilder(
    column: $table.externalSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FranchisesTableAnnotationComposer get franchiseId {
    final $$FranchisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.franchiseId,
      referencedTable: $db.franchises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FranchisesTableAnnotationComposer(
            $db: $db,
            $table: $db.franchises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> watchOrderStepsRefs<T extends Object>(
    Expression<T> Function($$WatchOrderStepsTableAnnotationComposer a) f,
  ) {
    final $$WatchOrderStepsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.watchOrderSteps,
      getReferencedColumn: (t) => t.mediaItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WatchOrderStepsTableAnnotationComposer(
            $db: $db,
            $table: $db.watchOrderSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> historyEntriesRefs<T extends Object>(
    Expression<T> Function($$HistoryEntriesTableAnnotationComposer a) f,
  ) {
    final $$HistoryEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.historyEntries,
      getReferencedColumn: (t) => t.mediaItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HistoryEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.historyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> metadataCacheEntriesRefs<T extends Object>(
    Expression<T> Function($$MetadataCacheEntriesTableAnnotationComposer a) f,
  ) {
    final $$MetadataCacheEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.metadataCacheEntries,
          getReferencedColumn: (t) => t.mediaItemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MetadataCacheEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.metadataCacheEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> mediaItemTagsRefs<T extends Object>(
    Expression<T> Function($$MediaItemTagsTableAnnotationComposer a) f,
  ) {
    final $$MediaItemTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mediaItemTags,
      getReferencedColumn: (t) => t.mediaItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaItemTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MediaItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MediaItemsTable,
          MediaItem,
          $$MediaItemsTableFilterComposer,
          $$MediaItemsTableOrderingComposer,
          $$MediaItemsTableAnnotationComposer,
          $$MediaItemsTableCreateCompanionBuilder,
          $$MediaItemsTableUpdateCompanionBuilder,
          (MediaItem, $$MediaItemsTableReferences),
          MediaItem,
          PrefetchHooks Function({
            bool franchiseId,
            bool watchOrderStepsRefs,
            bool historyEntriesRefs,
            bool metadataCacheEntriesRefs,
            bool mediaItemTagsRefs,
          })
        > {
  $$MediaItemsTableTableManager(_$AppDatabase db, $MediaItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediaItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediaItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediaItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> originalTitle = const Value.absent(),
                Value<MediaType> mediaType = const Value.absent(),
                Value<MediaStatus> status = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> creators = const Value.absent(),
                Value<String?> coverUrl = const Value.absent(),
                Value<DateTime?> releaseDate = const Value.absent(),
                Value<double?> rating = const Value.absent(),
                Value<int?> pageCount = const Value.absent(),
                Value<int?> chapterCount = const Value.absent(),
                Value<int?> episodeCount = const Value.absent(),
                Value<int?> runtimeMinutes = const Value.absent(),
                Value<int?> trackCount = const Value.absent(),
                Value<String?> platform = const Value.absent(),
                Value<String?> isbn = const Value.absent(),
                Value<int> progress = const Value.absent(),
                Value<int?> totalProgress = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> franchiseId = const Value.absent(),
                Value<String?> externalSource = const Value.absent(),
                Value<String?> externalId = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MediaItemsCompanion(
                id: id,
                title: title,
                originalTitle: originalTitle,
                mediaType: mediaType,
                status: status,
                description: description,
                creators: creators,
                coverUrl: coverUrl,
                releaseDate: releaseDate,
                rating: rating,
                pageCount: pageCount,
                chapterCount: chapterCount,
                episodeCount: episodeCount,
                runtimeMinutes: runtimeMinutes,
                trackCount: trackCount,
                platform: platform,
                isbn: isbn,
                progress: progress,
                totalProgress: totalProgress,
                notes: notes,
                franchiseId: franchiseId,
                externalSource: externalSource,
                externalId: externalId,
                startedAt: startedAt,
                finishedAt: finishedAt,
                addedAt: addedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String title,
                Value<String?> originalTitle = const Value.absent(),
                required MediaType mediaType,
                Value<MediaStatus> status = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> creators = const Value.absent(),
                Value<String?> coverUrl = const Value.absent(),
                Value<DateTime?> releaseDate = const Value.absent(),
                Value<double?> rating = const Value.absent(),
                Value<int?> pageCount = const Value.absent(),
                Value<int?> chapterCount = const Value.absent(),
                Value<int?> episodeCount = const Value.absent(),
                Value<int?> runtimeMinutes = const Value.absent(),
                Value<int?> trackCount = const Value.absent(),
                Value<String?> platform = const Value.absent(),
                Value<String?> isbn = const Value.absent(),
                Value<int> progress = const Value.absent(),
                Value<int?> totalProgress = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> franchiseId = const Value.absent(),
                Value<String?> externalSource = const Value.absent(),
                Value<String?> externalId = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MediaItemsCompanion.insert(
                id: id,
                title: title,
                originalTitle: originalTitle,
                mediaType: mediaType,
                status: status,
                description: description,
                creators: creators,
                coverUrl: coverUrl,
                releaseDate: releaseDate,
                rating: rating,
                pageCount: pageCount,
                chapterCount: chapterCount,
                episodeCount: episodeCount,
                runtimeMinutes: runtimeMinutes,
                trackCount: trackCount,
                platform: platform,
                isbn: isbn,
                progress: progress,
                totalProgress: totalProgress,
                notes: notes,
                franchiseId: franchiseId,
                externalSource: externalSource,
                externalId: externalId,
                startedAt: startedAt,
                finishedAt: finishedAt,
                addedAt: addedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MediaItemsTable, MediaItem>(table),
                  $$MediaItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                franchiseId = false,
                watchOrderStepsRefs = false,
                historyEntriesRefs = false,
                metadataCacheEntriesRefs = false,
                mediaItemTagsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (watchOrderStepsRefs) db.watchOrderSteps,
                    if (historyEntriesRefs) db.historyEntries,
                    if (metadataCacheEntriesRefs) db.metadataCacheEntries,
                    if (mediaItemTagsRefs) db.mediaItemTags,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (franchiseId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.franchiseId,
                            referencedTable: $$MediaItemsTableReferences
                                ._franchiseIdTable(db),
                            referencedColumn: $$MediaItemsTableReferences
                                ._franchiseIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (watchOrderStepsRefs)
                        await $_getPrefetchedData<
                          MediaItem,
                          $MediaItemsTable,
                          WatchOrderStep
                        >(
                          currentTable: table,
                          referencedTable: $$MediaItemsTableReferences
                              ._watchOrderStepsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MediaItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).watchOrderStepsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mediaItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (historyEntriesRefs)
                        await $_getPrefetchedData<
                          MediaItem,
                          $MediaItemsTable,
                          HistoryEntry
                        >(
                          currentTable: table,
                          referencedTable: $$MediaItemsTableReferences
                              ._historyEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MediaItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).historyEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mediaItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (metadataCacheEntriesRefs)
                        await $_getPrefetchedData<
                          MediaItem,
                          $MediaItemsTable,
                          MetadataCacheEntry
                        >(
                          currentTable: table,
                          referencedTable: $$MediaItemsTableReferences
                              ._metadataCacheEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MediaItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).metadataCacheEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mediaItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mediaItemTagsRefs)
                        await $_getPrefetchedData<
                          MediaItem,
                          $MediaItemsTable,
                          MediaItemTag
                        >(
                          currentTable: table,
                          referencedTable: $$MediaItemsTableReferences
                              ._mediaItemTagsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MediaItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).mediaItemTagsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mediaItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MediaItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MediaItemsTable,
      MediaItem,
      $$MediaItemsTableFilterComposer,
      $$MediaItemsTableOrderingComposer,
      $$MediaItemsTableAnnotationComposer,
      $$MediaItemsTableCreateCompanionBuilder,
      $$MediaItemsTableUpdateCompanionBuilder,
      (MediaItem, $$MediaItemsTableReferences),
      MediaItem,
      PrefetchHooks Function({
        bool franchiseId,
        bool watchOrderStepsRefs,
        bool historyEntriesRefs,
        bool metadataCacheEntriesRefs,
        bool mediaItemTagsRefs,
      })
    >;
typedef $$WatchOrdersTableCreateCompanionBuilder =
    WatchOrdersCompanion Function({
      Value<String> id,
      required String name,
      Value<String?> description,
      Value<String?> author,
      Value<String?> franchiseId,
      Value<bool> isUserCreated,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$WatchOrdersTableUpdateCompanionBuilder =
    WatchOrdersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<String?> author,
      Value<String?> franchiseId,
      Value<bool> isUserCreated,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$WatchOrdersTableReferences
    extends BaseReferences<_$AppDatabase, $WatchOrdersTable, WatchOrder> {
  $$WatchOrdersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FranchisesTable _franchiseIdTable(_$AppDatabase db) =>
      db.franchises.createAlias('watch_orders__franchise_id__franchises__id');

  $$FranchisesTableProcessedTableManager? get franchiseId {
    final $_column = $_itemColumn<String>('franchise_id');
    if ($_column == null) return null;
    final manager = $$FranchisesTableTableManager(
      $_db,
      $_db.franchises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_franchiseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$WatchOrderStepsTable, List<WatchOrderStep>>
  _watchOrderStepsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.watchOrderSteps,
    aliasName: 'watch_orders__id__watch_order_steps__order_id',
  );

  $$WatchOrderStepsTableProcessedTableManager get watchOrderStepsRefs {
    final manager = $$WatchOrderStepsTableTableManager(
      $_db,
      $_db.watchOrderSteps,
    ).filter((f) => f.orderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _watchOrderStepsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WatchOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $WatchOrdersTable> {
  $$WatchOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$FranchisesTableFilterComposer get franchiseId {
    final $$FranchisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.franchiseId,
      referencedTable: $db.franchises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FranchisesTableFilterComposer(
            $db: $db,
            $table: $db.franchises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> watchOrderStepsRefs(
    Expression<bool> Function($$WatchOrderStepsTableFilterComposer f) f,
  ) {
    final $$WatchOrderStepsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.watchOrderSteps,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WatchOrderStepsTableFilterComposer(
            $db: $db,
            $table: $db.watchOrderSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WatchOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $WatchOrdersTable> {
  $$WatchOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$FranchisesTableOrderingComposer get franchiseId {
    final $$FranchisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.franchiseId,
      referencedTable: $db.franchises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FranchisesTableOrderingComposer(
            $db: $db,
            $table: $db.franchises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WatchOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $WatchOrdersTable> {
  $$WatchOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$FranchisesTableAnnotationComposer get franchiseId {
    final $$FranchisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.franchiseId,
      referencedTable: $db.franchises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FranchisesTableAnnotationComposer(
            $db: $db,
            $table: $db.franchises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> watchOrderStepsRefs<T extends Object>(
    Expression<T> Function($$WatchOrderStepsTableAnnotationComposer a) f,
  ) {
    final $$WatchOrderStepsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.watchOrderSteps,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WatchOrderStepsTableAnnotationComposer(
            $db: $db,
            $table: $db.watchOrderSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WatchOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WatchOrdersTable,
          WatchOrder,
          $$WatchOrdersTableFilterComposer,
          $$WatchOrdersTableOrderingComposer,
          $$WatchOrdersTableAnnotationComposer,
          $$WatchOrdersTableCreateCompanionBuilder,
          $$WatchOrdersTableUpdateCompanionBuilder,
          (WatchOrder, $$WatchOrdersTableReferences),
          WatchOrder,
          PrefetchHooks Function({bool franchiseId, bool watchOrderStepsRefs})
        > {
  $$WatchOrdersTableTableManager(_$AppDatabase db, $WatchOrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WatchOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WatchOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WatchOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> franchiseId = const Value.absent(),
                Value<bool> isUserCreated = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WatchOrdersCompanion(
                id: id,
                name: name,
                description: description,
                author: author,
                franchiseId: franchiseId,
                isUserCreated: isUserCreated,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> franchiseId = const Value.absent(),
                Value<bool> isUserCreated = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WatchOrdersCompanion.insert(
                id: id,
                name: name,
                description: description,
                author: author,
                franchiseId: franchiseId,
                isUserCreated: isUserCreated,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WatchOrdersTable, WatchOrder>(table),
                  $$WatchOrdersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({franchiseId = false, watchOrderStepsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (watchOrderStepsRefs) db.watchOrderSteps,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (franchiseId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.franchiseId,
                            referencedTable: $$WatchOrdersTableReferences
                                ._franchiseIdTable(db),
                            referencedColumn: $$WatchOrdersTableReferences
                                ._franchiseIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (watchOrderStepsRefs)
                        await $_getPrefetchedData<
                          WatchOrder,
                          $WatchOrdersTable,
                          WatchOrderStep
                        >(
                          currentTable: table,
                          referencedTable: $$WatchOrdersTableReferences
                              ._watchOrderStepsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WatchOrdersTableReferences(
                                db,
                                table,
                                p0,
                              ).watchOrderStepsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.orderId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WatchOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WatchOrdersTable,
      WatchOrder,
      $$WatchOrdersTableFilterComposer,
      $$WatchOrdersTableOrderingComposer,
      $$WatchOrdersTableAnnotationComposer,
      $$WatchOrdersTableCreateCompanionBuilder,
      $$WatchOrdersTableUpdateCompanionBuilder,
      (WatchOrder, $$WatchOrdersTableReferences),
      WatchOrder,
      PrefetchHooks Function({bool franchiseId, bool watchOrderStepsRefs})
    >;
typedef $$WatchOrderStepsTableCreateCompanionBuilder =
    WatchOrderStepsCompanion Function({
      Value<String> id,
      required String orderId,
      required int position,
      Value<String?> mediaItemId,
      required String title,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$WatchOrderStepsTableUpdateCompanionBuilder =
    WatchOrderStepsCompanion Function({
      Value<String> id,
      Value<String> orderId,
      Value<int> position,
      Value<String?> mediaItemId,
      Value<String> title,
      Value<String?> note,
      Value<int> rowid,
    });

final class $$WatchOrderStepsTableReferences
    extends
        BaseReferences<_$AppDatabase, $WatchOrderStepsTable, WatchOrderStep> {
  $$WatchOrderStepsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WatchOrdersTable _orderIdTable(_$AppDatabase db) => db.watchOrders
      .createAlias('watch_order_steps__order_id__watch_orders__id');

  $$WatchOrdersTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<String>('order_id')!;

    final manager = $$WatchOrdersTableTableManager(
      $_db,
      $_db.watchOrders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MediaItemsTable _mediaItemIdTable(_$AppDatabase db) => db.mediaItems
      .createAlias('watch_order_steps__media_item_id__media_items__id');

  $$MediaItemsTableProcessedTableManager? get mediaItemId {
    final $_column = $_itemColumn<String>('media_item_id');
    if ($_column == null) return null;
    final manager = $$MediaItemsTableTableManager(
      $_db,
      $_db.mediaItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mediaItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WatchOrderStepsTableFilterComposer
    extends Composer<_$AppDatabase, $WatchOrderStepsTable> {
  $$WatchOrderStepsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$WatchOrdersTableFilterComposer get orderId {
    final $$WatchOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.watchOrders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WatchOrdersTableFilterComposer(
            $db: $db,
            $table: $db.watchOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaItemsTableFilterComposer get mediaItemId {
    final $$MediaItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaItemId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableFilterComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WatchOrderStepsTableOrderingComposer
    extends Composer<_$AppDatabase, $WatchOrderStepsTable> {
  $$WatchOrderStepsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$WatchOrdersTableOrderingComposer get orderId {
    final $$WatchOrdersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.watchOrders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WatchOrdersTableOrderingComposer(
            $db: $db,
            $table: $db.watchOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaItemsTableOrderingComposer get mediaItemId {
    final $$MediaItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaItemId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableOrderingComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WatchOrderStepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WatchOrderStepsTable> {
  $$WatchOrderStepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$WatchOrdersTableAnnotationComposer get orderId {
    final $$WatchOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.watchOrders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WatchOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.watchOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaItemsTableAnnotationComposer get mediaItemId {
    final $$MediaItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaItemId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WatchOrderStepsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WatchOrderStepsTable,
          WatchOrderStep,
          $$WatchOrderStepsTableFilterComposer,
          $$WatchOrderStepsTableOrderingComposer,
          $$WatchOrderStepsTableAnnotationComposer,
          $$WatchOrderStepsTableCreateCompanionBuilder,
          $$WatchOrderStepsTableUpdateCompanionBuilder,
          (WatchOrderStep, $$WatchOrderStepsTableReferences),
          WatchOrderStep,
          PrefetchHooks Function({bool orderId, bool mediaItemId})
        > {
  $$WatchOrderStepsTableTableManager(
    _$AppDatabase db,
    $WatchOrderStepsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WatchOrderStepsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WatchOrderStepsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WatchOrderStepsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> orderId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String?> mediaItemId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WatchOrderStepsCompanion(
                id: id,
                orderId: orderId,
                position: position,
                mediaItemId: mediaItemId,
                title: title,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String orderId,
                required int position,
                Value<String?> mediaItemId = const Value.absent(),
                required String title,
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WatchOrderStepsCompanion.insert(
                id: id,
                orderId: orderId,
                position: position,
                mediaItemId: mediaItemId,
                title: title,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WatchOrderStepsTable, WatchOrderStep>(table),
                  $$WatchOrderStepsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({orderId = false, mediaItemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (orderId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.orderId,
                        referencedTable: $$WatchOrderStepsTableReferences
                            ._orderIdTable(db),
                        referencedColumn: $$WatchOrderStepsTableReferences
                            ._orderIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (mediaItemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mediaItemId,
                        referencedTable: $$WatchOrderStepsTableReferences
                            ._mediaItemIdTable(db),
                        referencedColumn: $$WatchOrderStepsTableReferences
                            ._mediaItemIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WatchOrderStepsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WatchOrderStepsTable,
      WatchOrderStep,
      $$WatchOrderStepsTableFilterComposer,
      $$WatchOrderStepsTableOrderingComposer,
      $$WatchOrderStepsTableAnnotationComposer,
      $$WatchOrderStepsTableCreateCompanionBuilder,
      $$WatchOrderStepsTableUpdateCompanionBuilder,
      (WatchOrderStep, $$WatchOrderStepsTableReferences),
      WatchOrderStep,
      PrefetchHooks Function({bool orderId, bool mediaItemId})
    >;
typedef $$HistoryEntriesTableCreateCompanionBuilder =
    HistoryEntriesCompanion Function({
      Value<String> id,
      required String mediaItemId,
      required HistoryEventType eventType,
      Value<DateTime> occurredAt,
      Value<int?> progress,
      Value<double?> rating,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$HistoryEntriesTableUpdateCompanionBuilder =
    HistoryEntriesCompanion Function({
      Value<String> id,
      Value<String> mediaItemId,
      Value<HistoryEventType> eventType,
      Value<DateTime> occurredAt,
      Value<int?> progress,
      Value<double?> rating,
      Value<String?> note,
      Value<int> rowid,
    });

final class $$HistoryEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $HistoryEntriesTable, HistoryEntry> {
  $$HistoryEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MediaItemsTable _mediaItemIdTable(_$AppDatabase db) => db.mediaItems
      .createAlias('history_entries__media_item_id__media_items__id');

  $$MediaItemsTableProcessedTableManager get mediaItemId {
    final $_column = $_itemColumn<String>('media_item_id')!;

    final manager = $$MediaItemsTableTableManager(
      $_db,
      $_db.mediaItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mediaItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HistoryEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $HistoryEntriesTable> {
  $$HistoryEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<HistoryEventType, HistoryEventType, String>
  get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$MediaItemsTableFilterComposer get mediaItemId {
    final $$MediaItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaItemId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableFilterComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HistoryEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $HistoryEntriesTable> {
  $$HistoryEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$MediaItemsTableOrderingComposer get mediaItemId {
    final $$MediaItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaItemId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableOrderingComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HistoryEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HistoryEntriesTable> {
  $$HistoryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HistoryEventType, String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$MediaItemsTableAnnotationComposer get mediaItemId {
    final $$MediaItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaItemId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HistoryEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HistoryEntriesTable,
          HistoryEntry,
          $$HistoryEntriesTableFilterComposer,
          $$HistoryEntriesTableOrderingComposer,
          $$HistoryEntriesTableAnnotationComposer,
          $$HistoryEntriesTableCreateCompanionBuilder,
          $$HistoryEntriesTableUpdateCompanionBuilder,
          (HistoryEntry, $$HistoryEntriesTableReferences),
          HistoryEntry,
          PrefetchHooks Function({bool mediaItemId})
        > {
  $$HistoryEntriesTableTableManager(
    _$AppDatabase db,
    $HistoryEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistoryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistoryEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistoryEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> mediaItemId = const Value.absent(),
                Value<HistoryEventType> eventType = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<int?> progress = const Value.absent(),
                Value<double?> rating = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HistoryEntriesCompanion(
                id: id,
                mediaItemId: mediaItemId,
                eventType: eventType,
                occurredAt: occurredAt,
                progress: progress,
                rating: rating,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String mediaItemId,
                required HistoryEventType eventType,
                Value<DateTime> occurredAt = const Value.absent(),
                Value<int?> progress = const Value.absent(),
                Value<double?> rating = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HistoryEntriesCompanion.insert(
                id: id,
                mediaItemId: mediaItemId,
                eventType: eventType,
                occurredAt: occurredAt,
                progress: progress,
                rating: rating,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HistoryEntriesTable, HistoryEntry>(table),
                  $$HistoryEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mediaItemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mediaItemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mediaItemId,
                        referencedTable: $$HistoryEntriesTableReferences
                            ._mediaItemIdTable(db),
                        referencedColumn: $$HistoryEntriesTableReferences
                            ._mediaItemIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HistoryEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HistoryEntriesTable,
      HistoryEntry,
      $$HistoryEntriesTableFilterComposer,
      $$HistoryEntriesTableOrderingComposer,
      $$HistoryEntriesTableAnnotationComposer,
      $$HistoryEntriesTableCreateCompanionBuilder,
      $$HistoryEntriesTableUpdateCompanionBuilder,
      (HistoryEntry, $$HistoryEntriesTableReferences),
      HistoryEntry,
      PrefetchHooks Function({bool mediaItemId})
    >;
typedef $$MetadataCacheEntriesTableCreateCompanionBuilder =
    MetadataCacheEntriesCompanion Function({
      Value<String> id,
      required String mediaItemId,
      required String source,
      Value<String?> externalId,
      required String payload,
      Value<DateTime> fetchedAt,
      Value<int> rowid,
    });
typedef $$MetadataCacheEntriesTableUpdateCompanionBuilder =
    MetadataCacheEntriesCompanion Function({
      Value<String> id,
      Value<String> mediaItemId,
      Value<String> source,
      Value<String?> externalId,
      Value<String> payload,
      Value<DateTime> fetchedAt,
      Value<int> rowid,
    });

final class $$MetadataCacheEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MetadataCacheEntriesTable,
          MetadataCacheEntry
        > {
  $$MetadataCacheEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MediaItemsTable _mediaItemIdTable(_$AppDatabase db) => db.mediaItems
      .createAlias('metadata_cache_entries__media_item_id__media_items__id');

  $$MediaItemsTableProcessedTableManager get mediaItemId {
    final $_column = $_itemColumn<String>('media_item_id')!;

    final manager = $$MediaItemsTableTableManager(
      $_db,
      $_db.mediaItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mediaItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MetadataCacheEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $MetadataCacheEntriesTable> {
  $$MetadataCacheEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MediaItemsTableFilterComposer get mediaItemId {
    final $$MediaItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaItemId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableFilterComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MetadataCacheEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MetadataCacheEntriesTable> {
  $$MetadataCacheEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MediaItemsTableOrderingComposer get mediaItemId {
    final $$MediaItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaItemId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableOrderingComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MetadataCacheEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MetadataCacheEntriesTable> {
  $$MetadataCacheEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  $$MediaItemsTableAnnotationComposer get mediaItemId {
    final $$MediaItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaItemId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MetadataCacheEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MetadataCacheEntriesTable,
          MetadataCacheEntry,
          $$MetadataCacheEntriesTableFilterComposer,
          $$MetadataCacheEntriesTableOrderingComposer,
          $$MetadataCacheEntriesTableAnnotationComposer,
          $$MetadataCacheEntriesTableCreateCompanionBuilder,
          $$MetadataCacheEntriesTableUpdateCompanionBuilder,
          (MetadataCacheEntry, $$MetadataCacheEntriesTableReferences),
          MetadataCacheEntry,
          PrefetchHooks Function({bool mediaItemId})
        > {
  $$MetadataCacheEntriesTableTableManager(
    _$AppDatabase db,
    $MetadataCacheEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetadataCacheEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MetadataCacheEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MetadataCacheEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> mediaItemId = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> externalId = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MetadataCacheEntriesCompanion(
                id: id,
                mediaItemId: mediaItemId,
                source: source,
                externalId: externalId,
                payload: payload,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String mediaItemId,
                required String source,
                Value<String?> externalId = const Value.absent(),
                required String payload,
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MetadataCacheEntriesCompanion.insert(
                id: id,
                mediaItemId: mediaItemId,
                source: source,
                externalId: externalId,
                payload: payload,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MetadataCacheEntriesTable, MetadataCacheEntry>(
                    table,
                  ),
                  $$MetadataCacheEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mediaItemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mediaItemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mediaItemId,
                        referencedTable: $$MetadataCacheEntriesTableReferences
                            ._mediaItemIdTable(db),
                        referencedColumn: $$MetadataCacheEntriesTableReferences
                            ._mediaItemIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MetadataCacheEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MetadataCacheEntriesTable,
      MetadataCacheEntry,
      $$MetadataCacheEntriesTableFilterComposer,
      $$MetadataCacheEntriesTableOrderingComposer,
      $$MetadataCacheEntriesTableAnnotationComposer,
      $$MetadataCacheEntriesTableCreateCompanionBuilder,
      $$MetadataCacheEntriesTableUpdateCompanionBuilder,
      (MetadataCacheEntry, $$MetadataCacheEntriesTableReferences),
      MetadataCacheEntry,
      PrefetchHooks Function({bool mediaItemId})
    >;
typedef $$TagsTableCreateCompanionBuilder = TagsCompanion Function({
  Value<String> id,
  required String name,
  Value<int> rowid,
});
typedef $$TagsTableUpdateCompanionBuilder = TagsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<int> rowid,
});

final class $$TagsTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTable, Tag> {
  $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MediaItemTagsTable, List<MediaItemTag>>
  _mediaItemTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mediaItemTags,
    aliasName: 'tags__id__media_item_tags__tag_id',
  );

  $$MediaItemTagsTableProcessedTableManager get mediaItemTagsRefs {
    final manager = $$MediaItemTagsTableTableManager(
      $_db,
      $_db.mediaItemTags,
    ).filter((f) => f.tagId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_mediaItemTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> mediaItemTagsRefs(
    Expression<bool> Function($$MediaItemTagsTableFilterComposer f) f,
  ) {
    final $$MediaItemTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mediaItemTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemTagsTableFilterComposer(
            $db: $db,
            $table: $db.mediaItemTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> mediaItemTagsRefs<T extends Object>(
    Expression<T> Function($$MediaItemTagsTableAnnotationComposer a) f,
  ) {
    final $$MediaItemTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mediaItemTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaItemTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          Tag,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (Tag, $$TagsTableReferences),
          Tag,
          PrefetchHooks Function({bool mediaItemTagsRefs})
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => TagsCompanion(id: id, name: name, rowid: rowid),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String name,
            Value<int> rowid = const Value.absent(),
          }) => TagsCompanion.insert(id: id, name: name, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TagsTable, Tag>(table),
                  $$TagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mediaItemTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (mediaItemTagsRefs) db.mediaItemTags,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (mediaItemTagsRefs)
                    await $_getPrefetchedData<Tag, $TagsTable, MediaItemTag>(
                      currentTable: table,
                      referencedTable: $$TagsTableReferences
                          ._mediaItemTagsRefsTable(db),
                      managerFromTypedResult: (p0) => $$TagsTableReferences(
                        db,
                        table,
                        p0,
                      ).mediaItemTagsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tagId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      Tag,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (Tag, $$TagsTableReferences),
      Tag,
      PrefetchHooks Function({bool mediaItemTagsRefs})
    >;
typedef $$MediaItemTagsTableCreateCompanionBuilder =
    MediaItemTagsCompanion Function({
      required String mediaItemId,
      required String tagId,
      Value<int> rowid,
    });
typedef $$MediaItemTagsTableUpdateCompanionBuilder =
    MediaItemTagsCompanion Function({
      Value<String> mediaItemId,
      Value<String> tagId,
      Value<int> rowid,
    });

final class $$MediaItemTagsTableReferences
    extends BaseReferences<_$AppDatabase, $MediaItemTagsTable, MediaItemTag> {
  $$MediaItemTagsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MediaItemsTable _mediaItemIdTable(_$AppDatabase db) => db.mediaItems
      .createAlias('media_item_tags__media_item_id__media_items__id');

  $$MediaItemsTableProcessedTableManager get mediaItemId {
    final $_column = $_itemColumn<String>('media_item_id')!;

    final manager = $$MediaItemsTableTableManager(
      $_db,
      $_db.mediaItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mediaItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIdTable(_$AppDatabase db) =>
      db.tags.createAlias('media_item_tags__tag_id__tags__id');

  $$TagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<String>('tag_id')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MediaItemTagsTableFilterComposer
    extends Composer<_$AppDatabase, $MediaItemTagsTable> {
  $$MediaItemTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MediaItemsTableFilterComposer get mediaItemId {
    final $$MediaItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaItemId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableFilterComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MediaItemTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $MediaItemTagsTable> {
  $$MediaItemTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MediaItemsTableOrderingComposer get mediaItemId {
    final $$MediaItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaItemId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableOrderingComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MediaItemTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MediaItemTagsTable> {
  $$MediaItemTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$MediaItemsTableAnnotationComposer get mediaItemId {
    final $$MediaItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaItemId,
      referencedTable: $db.mediaItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MediaItemTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MediaItemTagsTable,
          MediaItemTag,
          $$MediaItemTagsTableFilterComposer,
          $$MediaItemTagsTableOrderingComposer,
          $$MediaItemTagsTableAnnotationComposer,
          $$MediaItemTagsTableCreateCompanionBuilder,
          $$MediaItemTagsTableUpdateCompanionBuilder,
          (MediaItemTag, $$MediaItemTagsTableReferences),
          MediaItemTag,
          PrefetchHooks Function({bool mediaItemId, bool tagId})
        > {
  $$MediaItemTagsTableTableManager(_$AppDatabase db, $MediaItemTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediaItemTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediaItemTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediaItemTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> mediaItemId = const Value.absent(),
                Value<String> tagId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MediaItemTagsCompanion(
                mediaItemId: mediaItemId,
                tagId: tagId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String mediaItemId,
                required String tagId,
                Value<int> rowid = const Value.absent(),
              }) => MediaItemTagsCompanion.insert(
                mediaItemId: mediaItemId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MediaItemTagsTable, MediaItemTag>(table),
                  $$MediaItemTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mediaItemId = false, tagId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mediaItemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mediaItemId,
                        referencedTable: $$MediaItemTagsTableReferences
                            ._mediaItemIdTable(db),
                        referencedColumn: $$MediaItemTagsTableReferences
                            ._mediaItemIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (tagId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.tagId,
                        referencedTable: $$MediaItemTagsTableReferences
                            ._tagIdTable(db),
                        referencedColumn: $$MediaItemTagsTableReferences
                            ._tagIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MediaItemTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MediaItemTagsTable,
      MediaItemTag,
      $$MediaItemTagsTableFilterComposer,
      $$MediaItemTagsTableOrderingComposer,
      $$MediaItemTagsTableAnnotationComposer,
      $$MediaItemTagsTableCreateCompanionBuilder,
      $$MediaItemTagsTableUpdateCompanionBuilder,
      (MediaItemTag, $$MediaItemTagsTableReferences),
      MediaItemTag,
      PrefetchHooks Function({bool mediaItemId, bool tagId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSetting>(table),
                  BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FranchisesTableTableManager get franchises =>
      $$FranchisesTableTableManager(_db, _db.franchises);
  $$MediaItemsTableTableManager get mediaItems =>
      $$MediaItemsTableTableManager(_db, _db.mediaItems);
  $$WatchOrdersTableTableManager get watchOrders =>
      $$WatchOrdersTableTableManager(_db, _db.watchOrders);
  $$WatchOrderStepsTableTableManager get watchOrderSteps =>
      $$WatchOrderStepsTableTableManager(_db, _db.watchOrderSteps);
  $$HistoryEntriesTableTableManager get historyEntries =>
      $$HistoryEntriesTableTableManager(_db, _db.historyEntries);
  $$MetadataCacheEntriesTableTableManager get metadataCacheEntries =>
      $$MetadataCacheEntriesTableTableManager(_db, _db.metadataCacheEntries);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$MediaItemTagsTableTableManager get mediaItemTags =>
      $$MediaItemTagsTableTableManager(_db, _db.mediaItemTags);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
