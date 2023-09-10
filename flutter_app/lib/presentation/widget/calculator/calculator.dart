import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:math_expressions/math_expressions.dart';

import 'calculator_key.dart';
import 'calculator_keyboard.dart';

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final List<CalculatorKey> _keyHistory = [];

  _onPressed(CalculatorKey key) {
    // final currentValue = controller.text;
    // controller.text = '$currentValue$input';
    // BudgetLogger.instance.d(key.text);
    switch (key) {
      case CalculatorKey.clear:
      case CalculatorKey.back:
        _keyHistory.clear();
        _calculateResult();
        break;

      default:
        _keyHistory.add(key);
        _calculateResult();
    }
  }

  void _calculateResult() {
    if (_keyHistory.isEmpty) {
      BudgetLogger.instance.d("zero");
      return;
    }
    String expression = _keyHistory.map((e) => e.text).toList().join();
    BudgetLogger.instance.d("history: $expression");
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      BudgetLogger.instance.d("result $result");
      // controller.text = result.toString();
    } catch (e) {
      // In case of invalid expression, clear the input
      BudgetLogger.instance.e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CalculatorKeyboard(onPressed: _onPressed);
  }
}
