import 'dart:async';

import 'package:flutter_app/data/data.dart';

class CategoryCacheService {
  final BookingClient bookingClient;

  List<CategoryModel>? _cachedCategories;
  DateTime? _lastCacheTime;
  bool _isFetchingCategories = false;
  final Duration cacheDuration = const Duration(minutes: 5);
  final Completer<List<CategoryModel>> _categoriesFetchCompleter = Completer<List<CategoryModel>>();

  CategoryCacheService(this.bookingClient);

  Future<List<CategoryModel>> getAllCategories() async {
    if (_cachedCategories != null && _lastCacheTime != null && DateTime.now().difference(_lastCacheTime!) <= cacheDuration) {
      return _cachedCategories!;
    }

    if (_isFetchingCategories) {
      return _categoriesFetchCompleter.future;
    }

    _isFetchingCategories = true;

    try {
      final categories = await bookingClient.getAllCategories();

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
}
