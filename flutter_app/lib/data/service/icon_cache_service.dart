import 'dart:async';

import 'package:flutter_app/data/data.dart';

class IconCacheService {
  final CategoryClient categoryClient;

  IconCacheModel? _cache;
  bool _isFetchingCategories = false;
  final Completer<IconCacheModel> _categoriesFetchCompleter = Completer<IconCacheModel>();

  IconCacheService(this.categoryClient);

  Future<IconCacheModel> getIconCache() async {
    if (_cache != null) {
      return _cache!;
    }

    if (_isFetchingCategories) {
      return _categoriesFetchCompleter.future;
    }
    _isFetchingCategories = true;

    try {
      final categoryIconNames = await categoryClient.getCategoryIcons();
      final categoryIconColors = await categoryClient.getCategoryColors();
      final cache = IconCacheModel(
        categoryIcons: categoryIconNames,
        categoryColors: categoryIconColors,
      );

      _cache = cache;

      _isFetchingCategories = false;
      _categoriesFetchCompleter.complete(_cache);

      return cache;
    } catch (e) {
      _isFetchingCategories = false;
      _categoriesFetchCompleter.completeError(e);

      rethrow;
    }
  }
}
