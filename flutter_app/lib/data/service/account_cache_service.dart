import 'package:flutter_app/data/data.dart';

import 'base/base_cache_service.dart';

class AccountCacheService extends BaseCacheService<List<AccountDataModel>> {
  final BookingClient bookingClient;

  AccountCacheService(this.bookingClient);

  @override
  Future<List<AccountDataModel>> fetchData() {
    return bookingClient.getAccounts();
  }

  @override
  Duration getCacheDuration() {
    return const Duration(minutes: 5);
  }
}
