import 'dart:async';

import 'package:flutter_app/utils/logger.dart';

abstract class BaseCacheService<T> {
  T? _cachedData;
  DateTime? _lastCacheTime;
  bool _isFetchingData = false;
  final Completer<T> _dataFetchCompleter = Completer<T>();

  Future<T> getData({bool forceReload = false}) async {
    if (!forceReload && _canUseCache()) {
      BudgetLogger.instance.d("use cache for $T");
      return _cachedData!;
    }

    if (_isFetchingData) {
      return _dataFetchCompleter.future;
    }

    _isFetchingData = true;

    try {
      final data = await fetchData();

      _cachedData = data;
      _lastCacheTime = DateTime.now();

      _isFetchingData = false;
      if (!_dataFetchCompleter.isCompleted) {
        _dataFetchCompleter.complete(_cachedData);
      }

      return data;
    } catch (e) {
      _isFetchingData = false;
      if (!_dataFetchCompleter.isCompleted) {
        _dataFetchCompleter.completeError(e);
      }

      rethrow;
    }
  }

  bool _canUseCache() {
    if (_cachedData == null || _lastCacheTime == null) {
      return false;
    }
    return DateTime.now().difference(_lastCacheTime!) <= getCacheDuration()!;
  }

  clear() {
    _cachedData = null;
    _lastCacheTime = null;
    _isFetchingData = false;
  }

  Future<T> fetchData();
  Duration getCacheDuration();
}
