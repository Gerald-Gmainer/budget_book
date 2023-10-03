import 'dart:async';

import 'package:flutter_app/data/data.dart';

class CategoryCacheService {
  final BookingClient bookingClient;

  List<CategoryDataModel>? _cachedCategories;
  DateTime? _lastCacheTime;
  bool _isFetchingCategories = false;
  final Duration cacheDuration = const Duration(minutes: 5);
  final Completer<List<CategoryDataModel>> _categoriesFetchCompleter = Completer<List<CategoryDataModel>>();

  CategoryCacheService(this.bookingClient);

  Future<List<CategoryDataModel>> getAllCategories() async {
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
