import 'dart:async';

import 'package:flutter_app/data/data.dart';

import 'base/base_cache_service.dart';

class IconCacheService extends BaseCacheService<IconCacheModel> {
  final CategoryClient categoryClient;
  final AccountClient accountClient;

  IconCacheService(this.categoryClient, this.accountClient);

  @override
  Future<IconCacheModel> fetchData() async {
    final categoryIcons = await categoryClient.getCategoryIcons();
    final categoryIconColors = await categoryClient.getCategoryColors();
    final accountIcons = await accountClient.getAccountIcons();
    final accountIconColors = await accountClient.getAccountColors();
    return IconCacheModel(
      categoryIcons: categoryIcons,
      categoryColors: categoryIconColors,
      accountIcons: accountIcons,
      accountColors: accountIconColors,
    );
  }

  @override
  Duration getCacheDuration() {
    return Duration(days: 7);
  }
}
