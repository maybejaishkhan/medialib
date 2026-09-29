/// Domain types for external metadata.
library;

/// One candidate returned by a provider's search.
class MetadataSearchResult {
  const MetadataSearchResult({
    required this.providerId,
    required this.externalId,
    required this.title,
    this.subtitle,
    this.year,
    this.thumbnailUrl,
    this.raw,
  });

  /// The id of the provider this result came from.
  final String providerId;

  /// The provider-specific identifier.
  final String externalId;

  final String title;

  /// A secondary line, typically creators or a media type.
  final String? subtitle;

  final int? year;
  final String? thumbnailUrl;

  /// The provider's raw decoded payload, if retained for [fetch].
  final Map<String, dynamic>? raw;
}

/// Normalised metadata fetched from a provider.
class MediaMetadata {
  const MediaMetadata({
    required this.providerId,
    required this.externalId,
    this.title,
    this.description,
    this.coverUrl,
    this.creators,
    this.releaseDate,
    this.rating,
    this.pageCount,
    this.chapterCount,
    this.episodeCount,
    this.runtimeMinutes,
    this.trackCount,
    this.isbn,
  });

  final String providerId;
  final String externalId;
  final String? title;
  final String? description;
  final String? coverUrl;
  final String? creators;
  final DateTime? releaseDate;

  /// A rating on a 0–10 scale.
  final double? rating;

  final int? pageCount;
  final int? chapterCount;
  final int? episodeCount;
  final int? runtimeMinutes;
  final int? trackCount;
  final String? isbn;

  /// A serialisable representation, used when caching metadata locally.
  Map<String, dynamic> toJson() => {
    'providerId': providerId,
    'externalId': externalId,
    'title': title,
    'description': description,
    'coverUrl': coverUrl,
    'creators': creators,
    'releaseDate': releaseDate?.toIso8601String(),
    'rating': rating,
    'pageCount': pageCount,
    'chapterCount': chapterCount,
    'episodeCount': episodeCount,
    'runtimeMinutes': runtimeMinutes,
    'trackCount': trackCount,
    'isbn': isbn,
  };
}

/// Thrown when a metadata provider cannot fulfil a request.
class MetadataException implements Exception {
  const MetadataException(this.message);

  final String message;

  @override
  String toString() => message;
}
