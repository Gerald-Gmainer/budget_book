import 'dart:async';

import 'package:flutter_app/data/data.dart';

class CategoryCacheService {
  final CategoryClient categoryClient;

  List<CategoryDataModel>? _cachedCategories;
  DateTime? _lastCacheTime;
  bool _isFetchingCategories = false;
  final Duration cacheDuration = const Duration(minutes: 5);
  final Completer<List<CategoryDataModel>> _categoriesFetchCompleter = Completer<List<CategoryDataModel>>();

  CategoryCacheService(this.categoryClient);

  Future<List<CategoryDataModel>> getAllCategories(bool forceReload) async {
    if (!forceReload && _canUseCache()) {
      return _cachedCategories!;
    }

    if (_isFetchingCategories) {
      return _categoriesFetchCompleter.future;
    }

    _isFetchingCategories = true;

    try {
      final categories = await categoryClient.getAllCategories();

      _cachedCategories = categories;
      _lastCacheTime = DateTime.now();

      _isFetchingCategories = false;
      _categoriesFetchCompleter.complete(_cachedCategories);

      return categories;
    } catch (e) {
      _isFetchingCategories = false;
      _categoriesFetchCompleter.completeError(e);

      rethrow;
    }
  }

  bool _canUseCache() {
    return _cachedCategories != null && _lastCacheTime != null && DateTime.now().difference(_lastCacheTime!) <= cacheDuration;
  }
}
