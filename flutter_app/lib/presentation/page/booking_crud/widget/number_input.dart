import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/page/booking_crud/widget/number_key.dart';

class NumberInput extends StatelessWidget {
  static const Color operatorColor = Color(0xFF4B535A);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 5,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(5),
      children: const [
        NumberKey(text: "7"),
        NumberKey(text: "8"),
        NumberKey(text: "9"),
        NumberKey(text: "/", backgroundColor: operatorColor),
        NumberKey(text: "AC", backgroundColor: Color(0xFFFF9999), fontColor: Colors.black),
        NumberKey(text: "4"),
        NumberKey(text: "5"),
        NumberKey(text: "6"),
        NumberKey(text: "X", backgroundColor: operatorColor),
        SizedBox.shrink(),
        NumberKey(text: "1"),
        NumberKey(text: "2"),
        NumberKey(text: "3"),
        NumberKey(text: "-", backgroundColor: operatorColor),
        SizedBox.shrink(),
        NumberKey(text: "0"),
        NumberKey(text: "."),
        NumberKey(text: "x"),
        NumberKey(text: "+", backgroundColor: operatorColor),
        NumberKey(text: "=", backgroundColor: operatorColor),
      ],
    );
  }
}
