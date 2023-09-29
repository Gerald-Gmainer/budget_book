import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'calculator_keyboard.dart';

export 'calculator_key.dart';

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  _onPressed(CalculatorKey key) {
    switch (key) {
      case CalculatorKey.clear:
        BlocProvider.of<CalculatorBloc>(context).add(ClearCalculatorEvent());
        break;

      case CalculatorKey.back:
        BlocProvider.of<CalculatorBloc>(context).add(BackCalculatorEvent());
        break;

      case CalculatorKey.equal:
        BlocProvider.of<CalculatorBloc>(context).add(EqualCalculatorEvent());
        break;

      default:
        BlocProvider.of<CalculatorBloc>(context).add(KeyCalculatorEvent(key));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CalculatorKeyboard(onPressed: _onPressed);
  }
}
