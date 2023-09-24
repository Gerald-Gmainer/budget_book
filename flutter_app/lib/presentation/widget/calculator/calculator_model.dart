import 'package:flutter/material.dart';

import 'calculator.dart';

class CalculatorModel {
  final ValueNotifier<List<CalculatorKey>> _history = ValueNotifier<List<CalculatorKey>>([]);
  final ValueNotifier<double> _result = ValueNotifier<double>(0);

  ValueNotifier<List<CalculatorKey>> get history => _history;
  ValueNotifier<double> get result => _result;

  addHistory(CalculatorKey key) {
    _history.value = [..._history.value, key];
  }

  clearHistory() {
    _history.value = [];
  }

  setResult(double value) {
    _result.value = value;
  }

  clearResult() {
    _result.value = 0;
  }
}
