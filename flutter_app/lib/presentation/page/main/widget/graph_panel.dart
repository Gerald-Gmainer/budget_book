import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GraphPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPaginatorBloc, MainPaginatorState>(
      builder: (context, state) {
        return Container(
          color: Colors.grey,
          child: const Center(child: Text("graph")),
        );
      },
    );
  }
}
