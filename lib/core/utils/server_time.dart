/// Parses a timestamp coming from the API — either a full ISO 8601 string
/// (`serverTime`, already UTC with a `Z`/offset) or MySQL's bare
/// `YYYY-MM-DD HH:MM:SS` row format (the API's connection pool uses
/// `dateStrings: true`, and MySQL runs on its default UTC session
/// timezone on the VPS). [DateTime.parse] treats a string with no
/// timezone marker as *local* time, which would silently misinterpret
/// these — so a trailing `Z` is forced on before parsing whenever one
/// isn't already present.
DateTime parseServerDateTime(String value) {
  final hasOffset = value.endsWith('Z') || RegExp(r'[+-]\d\d:?\d\d$').hasMatch(value);
  final normalized = hasOffset ? value : '${value.replaceFirst(' ', 'T')}Z';
  return DateTime.parse(normalized);
}
