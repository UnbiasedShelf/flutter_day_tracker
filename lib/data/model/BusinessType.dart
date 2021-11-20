enum BusinessType {
  CHILL,
  WORK,
  STUDYING,
  ROAD,
  LUNCH,
  SLEEP
}

extension EnumTransform on List {
  String? string<T>(T value) {
    if (value == null || (isEmpty)) return null;
    BusinessType? occurrence = singleWhere(
            (enumItem) => enumItem.toString() == value.toString(),
        orElse: null);
    return occurrence?.toString().split('.').last;
  }

  T? enumFromString<T>(String value) {
    return firstWhere((type) => type.toString().split('.').last == value,
        orElse: null);
  }
}