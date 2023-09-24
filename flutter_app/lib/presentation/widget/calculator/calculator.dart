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
        if (widget.model.history.value.isNotEmpty) {
          widget.model.backHistory();
          _calculateResult();
        }
        break;
      case CalculatorKey.equal:
        widget.model.equalHistory();
        _calculateResult();
        break;

      default:
        widget.model.addHistory(key.calculateText);
        _calculateResult();
    }
  }

  void _calculateResult() {
    if (widget.model.history.value.isEmpty) {
      BudgetLogger.instance.d("zero");
      widget.model.setResult(0);
      return;
    }
    String expression = widget.model.history.value.join();
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
