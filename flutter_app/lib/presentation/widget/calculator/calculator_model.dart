import 'package:flutter/material.dart';

import 'calculator.dart';

class CalculatorModel {
  final ValueNotifier<List<String>> _history = ValueNotifier<List<String>>([]);
  final ValueNotifier<double> _result = ValueNotifier<double>(0);

  ValueNotifier<List<String>> get history => _history;
  ValueNotifier<double> get result => _result;

  addHistory(String key) {
    _history.value = [..._history.value, key];
  }

  clearHistory() {
    _history.value = [];
  }

  backHistory() {
    _history.value = _history.value.sublist(0, _history.value.length - 1);
  }

  equalHistory() {
    // TODO uniform calculation with amount display
    final value = _result.value == _result.value.truncate() ? _result.value.toStringAsFixed(0) : _result.value.toStringAsFixed(2);
    _history.value = [value];
  }

  setResult(double value) {
    _result.value = value;
  }

  clearResult() {
    _result.value = 0;
  }
}
