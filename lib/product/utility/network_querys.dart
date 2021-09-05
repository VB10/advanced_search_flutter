enum NetworkQuery { page, per_page }

extension NetworkQueryExtension on NetworkQuery {
  MapEntry<String, String> rawValue(String value) {
    switch (this) {
      case NetworkQuery.page:
        return MapEntry('page', value);
      case NetworkQuery.per_page:
        return MapEntry('per_page', value);
    }
  }
}
