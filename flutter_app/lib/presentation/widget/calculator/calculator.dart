import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:math_expressions/math_expressions.dart';

import 'calculator_keyboard.dart';

export 'calculator_key.dart';
export 'calculator_model.dart';

class Calculator extends StatefulWidget {
  final CalculatorModel model;

  const Calculator({required this.model});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  _onPressed(CalculatorKey key) {
    switch (key) {
      case CalculatorKey.clear:
        widget.model.clearHistory();
        widget.model.clearResult();
        break;
      case CalculatorKey.back:
        widget.model.backHistory();
        _calculateResult();
        break;

      default:
        widget.model.addHistory(key);
        _calculateResult();
    }
  }

  void _calculateResult() {
    if (widget.model.history.value.isEmpty) {
      BudgetLogger.instance.d("zero");
      return;
    }
    String expression = widget.model.history.value.map((e) => e.calculateText).toList().join();
    // BudgetLogger.instance.d("history: $expression");
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      // BudgetLogger.instance.d("result $result");
      widget.model.setResult(result);
    } catch (e) {
      if (e is! RangeError) {
        BudgetLogger.instance.e(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CalculatorKeyboard(onPressed: _onPressed);
  }
}
