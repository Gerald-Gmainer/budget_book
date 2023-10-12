part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorEvent {}

class InitCalculatorEvent extends CalculatorEvent {
}

class ClearCalculatorEvent extends CalculatorEvent {

}

class BackCalculatorEvent extends CalculatorEvent {

}

class EqualCalculatorEvent extends CalculatorEvent {

}

class KeyCalculatorEvent extends CalculatorEvent {
  final CalculatorKey key;

  KeyCalculatorEvent(this.key);
}
