extension ListToString<T> on List<T>? {
  String joinByName({String separator = ', '}) {
    if (this == null || this!.isEmpty) return '';
    return this!
        .map((item) => (item as dynamic).name?.toString() ?? '')
        .where((name) => name.isNotEmpty)
        .join(separator);
  }

  String joinByIndex({String separator = ', '}) {
    if (this == null || this!.isEmpty) return '';
    return this!
        .map((item) => (item as dynamic).index?.toString() ?? '')
        .where((index) => index.isNotEmpty)
        .join(separator);
  }
}
