/// The media types supported by the unified library.
///
/// A single `MediaItems` row represents any of these; the per-type fields that
/// only apply to some types are left null.
enum MediaType {
  book('Book', 'Books'),
  comic('Comic', 'Comics'),
  manga('Manga', 'Manga'),
  anime('Anime', 'Anime'),
  movie('Movie', 'Movies'),
  tv('TV', 'TV'),
  game('Game', 'Games'),
  music('Music', 'Music');

  const MediaType(this.label, this.pluralLabel);

  /// A human-readable singular label.
  final String label;

  /// A human-readable plural label, used for grouping and filters.
  final String pluralLabel;
}

/// Where an entry sits in the user's consumption flow.
enum MediaStatus {
  planned('Planned'),
  inProgress('In progress'),
  completed('Completed'),
  onHold('On hold'),
  dropped('Dropped');

  const MediaStatus(this.label);

  final String label;
}

/// The kind of event recorded in the consumption history.
enum HistoryEventType {
  started('Started'),
  progressed('Progressed'),
  completed('Completed'),
  paused('Paused'),
  dropped('Dropped'),
  rated('Rated'),
  noted('Note');

  const HistoryEventType(this.label);

  final String label;
}
