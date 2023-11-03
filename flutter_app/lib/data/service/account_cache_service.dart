import 'package:flutter_app/data/data.dart';

import 'base/base_cache_service.dart';

class AccountCacheService extends BaseCacheService<List<AccountDataModel>> {
  final AccountClient accountClient;

  AccountCacheService(this.accountClient);

  @override
  Future<List<AccountDataModel>> fetchData() {
    return accountClient.getAccounts();
  }

  @override
  Duration getCacheDuration() {
    return const Duration(minutes: 5);
  }
}
