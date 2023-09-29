import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  static final operations = [CalculatorKey.addition, CalculatorKey.subtraction, CalculatorKey.multiplication, CalculatorKey.division];
  final Parser _parser = Parser();
  final ContextModel _context = ContextModel();
  List<String> _history = [];
  double _result = 0;

  CalculatorBloc() : super(CalculatorInitState()) {
    on<InitCalculatorEvent>(_onInitCalculatorEvent);
    on<ClearCalculatorEvent>(_onClearCalculatorEvent);
    on<BackCalculatorEvent>(_onBackCalculatorEvent);
    on<EqualCalculatorEvent>(_onEqualCalculatorEvent);
    on<KeyCalculatorEvent>(_onKeyCalculatorEvent);
  }

  _onInitCalculatorEvent(InitCalculatorEvent event, Emitter<CalculatorState> emit) async {
    _updateState(0, emit, history: []);
  }

  _onClearCalculatorEvent(ClearCalculatorEvent event, Emitter<CalculatorState> emit) async {
    _updateState(0, emit, history: []);
  }

  _onBackCalculatorEvent(BackCalculatorEvent event, Emitter<CalculatorState> emit) async {
    if (_history.isNotEmpty) {
      _history = _history.sublist(0, _history.length - 1);
      _calculateResult(emit);
    }
  }

  _onEqualCalculatorEvent(EqualCalculatorEvent event, Emitter<CalculatorState> emit) async {
    if (_history.isNotEmpty) {
      // TODO uniform calculation with amount display
      final value = _result == _result.truncate() ? _result.toStringAsFixed(0) : _result.toStringAsFixed(2);
      _history = [value];
      _calculateResult(emit);
    }
  }

  _onKeyCalculatorEvent(KeyCalculatorEvent event, Emitter<CalculatorState> emit) async {
    if (_isLastHistoryAOperation() && event.key.isOperation) {
      _history.removeLast();
    }
    _history.add(event.key.calculateText);
    _calculateResult(emit);
  }

  _updateState(double result, Emitter<CalculatorState> emit, {List<String>? history}) {
    if (history != null) {
      _history = history;
    }
    _result = result;
    emit(CalculatorUpdateState(_history, _result));
  }

  _calculateResult(Emitter<CalculatorState> emit) {
    if (_history.isEmpty) {
      BudgetLogger.instance.d("zero");
      _updateState(0, emit);
      return;
    }

    String expression = _formatExpression(_history);
    // BudgetLogger.instance.d("history: $expression");
    try {
      Expression exp = _parser.parse(expression);
      double result = exp.evaluate(EvaluationType.REAL, _context);
      // BudgetLogger.instance.d("result $result");
      _updateState(result, emit);
    } catch (e) {
      if (e is RangeError || e is FormatException) {
        _updateState(_result, emit);
      } else {
        BudgetLogger.instance.e(e);
      }
    }
  }

  _isLastHistoryAOperation() {
    if (_history.isEmpty) {
      return false;
    }
    String lastString = _history.last;
    return operations.map((key) => key.calculateText).contains(lastString);
  }

  _formatExpression(List<String> history) {
    final temp = [...history];
    String lastString = temp.last;
    if (operations.map((key) => key.calculateText).contains(lastString)) {
      temp.removeLast();
    }
    return temp.join();
  }
}
