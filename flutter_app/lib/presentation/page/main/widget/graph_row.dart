import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/model/budget_book_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GraphRow extends StatelessWidget {
  const GraphRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPaginatorBloc, MainPaginatorState>(
      builder: (context, state) {
        if (state is MainPaginatorLoadedState) {
          return _buildView(context, state.bookModel);
        }
        return Expanded(
          child: Container(
            color: Colors.grey,
            child: Center(child: Text("graph")),
          ),
        );
      },
    );
  }

  Widget _buildView(BuildContext context, BudgetBookModel bookModel) {
    return Column(
      children: bookModel.periodModels[0].bookings.map((e) => Text("${e.bookingDate.toString()} / ${e.amount}")).toList(),
    );
  }
}
