import 'dart:async';

import 'package:flutter_app/data/data.dart';

class CurrencyCacheService {
  final ProfileClient profileClient;

  List<CurrencyDataModel>? _currencies;
  bool _isFetchingCategories = false;
  final Completer<List<CurrencyDataModel>> _categoriesFetchCompleter = Completer<List<CurrencyDataModel>>();

  CurrencyCacheService(this.profileClient);

  Future<List<CurrencyDataModel>> getCurrencyCache() async {
    if (_currencies != null) {
      return _currencies!;
    }

    if (_isFetchingCategories) {
      return _categoriesFetchCompleter.future;
    }
    _isFetchingCategories = true;

    try {
      final currencies = await profileClient.getCurrencies();

      _currencies = currencies;

      _isFetchingCategories = false;
      _categoriesFetchCompleter.complete(_currencies);

      return currencies;
    } catch (e) {
      _isFetchingCategories = false;
      _categoriesFetchCompleter.completeError(e);

      rethrow;
    }
  }
}
