part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorState {}

class CalculatorInitState extends CalculatorState {}

class CalculatorUpdateState extends CalculatorState {
  final List<String> history;
  final double result;

  CalculatorUpdateState(this.history, this.result);
}
