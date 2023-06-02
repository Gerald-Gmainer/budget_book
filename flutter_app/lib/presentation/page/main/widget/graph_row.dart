import 'package:flutter/material.dart';

class GraphRow extends StatelessWidget {
  const GraphRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.grey,
        child: Center(child: Text("graph")),
      ),
    );
  }
}
