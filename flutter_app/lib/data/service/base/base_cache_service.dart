import 'dart:async';

abstract class BaseCacheService<T> {
  T? _cachedData;
  DateTime? _lastCacheTime;
  bool _isFetchingData = false;
  final Completer<T> _dataFetchCompleter = Completer<T>();

  Future<T> getData({bool forceReload = false}) async {
    if (!forceReload && _canUseCache()) {
      return _cachedData!;
    }

    if (_isFetchingData) {
      return _dataFetchCompleter.future;
    }

    _isFetchingData = true;

    try {
      final data = await fetchData();

      _cachedData = data;

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
    if (_cachedData != null || getCacheDuration() == null) {
      return false;
    }
    return _lastCacheTime != null && DateTime.now().difference(_lastCacheTime!) <= getCacheDuration()!;
  }

  Future<T> fetchData();
  Duration? getCacheDuration();
}
