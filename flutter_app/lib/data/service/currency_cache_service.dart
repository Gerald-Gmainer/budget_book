import 'dart:async';

import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/data/service/base/base_cache_service.dart';

class CurrencyCacheService extends BaseCacheService<List<CurrencyDataModel>> {
  final ProfileClient profileClient;

  CurrencyCacheService(this.profileClient);

  @override
  Future<List<CurrencyDataModel>> fetchData() {
    return profileClient.getCurrencies();
  }

  @override
  Duration getCacheDuration() {
    return Duration(days: 7);
  }
}
