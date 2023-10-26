import 'package:flutter_app/data/data.dart';

import 'base/base_cache_service.dart';

class SuggestionCacheService extends BaseCacheService<List<String>> {
  final BookingClient bookingClient;

  SuggestionCacheService(this.bookingClient);

  @override
  Future<List<String>> fetchData() {
    return bookingClient.getSuggestions();
  }

  @override
  Duration getCacheDuration() {
    return const Duration(minutes: 5);
  }
}
