/// Formatting helpers for the consumption history.
library;

const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

/// A human-friendly label for the day [date] falls on: "Today", "Yesterday",
/// or a date such as "3 Sep 2026".
String dayLabel(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final day = DateTime(date.year, date.month, date.day);
  final difference = today.difference(day).inDays;
  return switch (difference) {
    0 => 'Today',
    1 => 'Yesterday',
    _ => '${date.day} ${_months[date.month - 1]} ${date.year}',
  };
}

/// A 24-hour `HH:mm` label for [dateTime].
String timeLabel(DateTime dateTime) =>
    '${dateTime.hour.toString().padLeft(2, '0')}:'
    '${dateTime.minute.toString().padLeft(2, '0')}';

/// A label combining the day and time, e.g. "3 Sep 2026 · 14:05".
String dateTimeLabel(DateTime dateTime) =>
    '${dayLabel(dateTime)} · ${timeLabel(dateTime)}';
