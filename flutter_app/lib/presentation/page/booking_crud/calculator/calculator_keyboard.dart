import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'calculator_button.dart';
import 'calculator_key.dart';

class CalculatorKeyboard extends StatelessWidget {
  static const Color operatorColor = Color(0xFF4B535A);
  final Function(CalculatorKey) onPressed;

  const CalculatorKeyboard({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 5,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(5),
      children: [
        CalculatorButton(calculatorKey: CalculatorKey.digit7, onPressed: onPressed),
        CalculatorButton(calculatorKey: CalculatorKey.digit8, onPressed: onPressed),
        CalculatorButton(calculatorKey: CalculatorKey.digit9, onPressed: onPressed),
        CalculatorButton(
          calculatorKey: CalculatorKey.division,
          onPressed: onPressed,
          backgroundColor: operatorColor,
          icon: const FaIcon(FontAwesomeIcons.divide, size: 20),
        ),
        CalculatorButton(
          calculatorKey: CalculatorKey.clear,
          onPressed: onPressed,
          backgroundColor: const Color(0xFFB36565),
          // fontColor: Colors.black,
        ),
        CalculatorButton(calculatorKey: CalculatorKey.digit4, onPressed: onPressed),
        CalculatorButton(calculatorKey: CalculatorKey.digit5, onPressed: onPressed),
        CalculatorButton(calculatorKey: CalculatorKey.digit6, onPressed: onPressed),
        CalculatorButton(
          calculatorKey: CalculatorKey.multiplication,
          onPressed: onPressed,
          backgroundColor: operatorColor,
          icon: const FaIcon(FontAwesomeIcons.xmark, size: 20),
        ),
        const SizedBox.shrink(),
        CalculatorButton(calculatorKey: CalculatorKey.digit1, onPressed: onPressed),
        CalculatorButton(calculatorKey: CalculatorKey.digit2, onPressed: onPressed),
        CalculatorButton(calculatorKey: CalculatorKey.digit3, onPressed: onPressed),
        CalculatorButton(
          calculatorKey: CalculatorKey.subtraction,
          onPressed: onPressed,
          backgroundColor: operatorColor,
          icon: const FaIcon(FontAwesomeIcons.minus, size: 20),
        ),
        const SizedBox.shrink(),
        CalculatorButton(calculatorKey: CalculatorKey.digit0, onPressed: onPressed),
        CalculatorButton(
          calculatorKey: CalculatorKey.dot,
          onPressed: onPressed,
          icon: const FaIcon(FontAwesomeIcons.solidCircle, size: 5),
        ),
        CalculatorButton(
          calculatorKey: CalculatorKey.back,
          onPressed: onPressed,
          icon: const FaIcon(FontAwesomeIcons.deleteLeft, size: 20),
        ),
        CalculatorButton(
          calculatorKey: CalculatorKey.addition,
          onPressed: onPressed,
          backgroundColor: operatorColor,
          icon: const FaIcon(FontAwesomeIcons.plus, size: 20),
        ),
        CalculatorButton(
          calculatorKey: CalculatorKey.equal,
          onPressed: onPressed,
          backgroundColor: const Color(0xFF4875C9),
          icon: const FaIcon(FontAwesomeIcons.equals, size: 20),
        ),
      ],
    );
  }
}
