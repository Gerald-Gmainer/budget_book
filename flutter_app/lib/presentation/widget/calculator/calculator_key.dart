enum CalculatorKey {
  digit0,
  digit1,
  digit2,
  digit3,
  digit4,
  digit5,
  digit6,
  digit7,
  digit8,
  digit9,
  dot,
  addition,
  subtraction,
  multiplication,
  division,
  back,
  clear,
  equal,
}

extension CalculatorKeyExtension on CalculatorKey {
  String get displayText {
    switch (this) {
      case CalculatorKey.digit0:
        return "0";
      case CalculatorKey.digit1:
        return "1";
      case CalculatorKey.digit2:
        return "2";
      case CalculatorKey.digit3:
        return "3";
      case CalculatorKey.digit4:
        return "4";
      case CalculatorKey.digit5:
        return "5";
      case CalculatorKey.digit6:
        return "6";
      case CalculatorKey.digit7:
        return "7";
      case CalculatorKey.digit8:
        return "8";
      case CalculatorKey.digit9:
        return "9";
      case CalculatorKey.clear:
        return "AC";

      default:
        return "NULL";
    }
  }

  String get calculateText {
    switch (this) {
      case CalculatorKey.digit0:
        return "0";
      case CalculatorKey.digit1:
        return "1";
      case CalculatorKey.digit2:
        return "2";
      case CalculatorKey.digit3:
        return "3";
      case CalculatorKey.digit4:
        return "4";
      case CalculatorKey.digit5:
        return "5";
      case CalculatorKey.digit6:
        return "6";
      case CalculatorKey.digit7:
        return "7";
      case CalculatorKey.digit8:
        return "8";
      case CalculatorKey.digit9:
        return "9";
      case CalculatorKey.addition:
        return "+";
      case CalculatorKey.subtraction:
        return "-";
      case CalculatorKey.multiplication:
        return "*";
      case CalculatorKey.division:
        return "/";
      case CalculatorKey.dot:
        return ".";
      default:
        return "NULL";
    }
  }

  bool get isOperation {
    switch (this) {
      case CalculatorKey.addition:
      case CalculatorKey.subtraction:
      case CalculatorKey.multiplication:
      case CalculatorKey.division:
        return true;

      default:
        return false;
    }
  }
}
