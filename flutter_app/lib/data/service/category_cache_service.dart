import 'dart:async';

import 'package:flutter_app/data/data.dart';

import 'base/base_cache_service.dart';

class CategoryCacheService extends BaseCacheService<List<CategoryDataModel>> {
  final CategoryClient categoryClient;

  CategoryCacheService(this.categoryClient);

  @override
  Future<List<CategoryDataModel>> fetchData() async {
    return await categoryClient.getAllCategories();
  }

  @override
  Duration? getCacheDuration() {
    return const Duration(minutes: 5);
  }
}
