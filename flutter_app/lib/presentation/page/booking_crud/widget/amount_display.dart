import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmountDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: BlocBuilder<CalculatorBloc, CalculatorState>(
          builder: (context, state) {
            final List<String> history = state is CalculatorUpdateState ? state.history : [];
            final double result = state is CalculatorUpdateState ? state.result : 0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildHistory(history),
                _buildResult(result),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHistory(List<String> history) {
    return Text(history.join(), style: const TextStyle(fontSize: 22, color: AppColors.primaryTextColor));
  }

  Widget _buildResult(double result) {
    final resultFormatted = result == result.truncate() ? result.toStringAsFixed(0) : result.toStringAsFixed(2);
    return Text(resultFormatted, style: const TextStyle(fontSize: 44, color: AppColors.primaryTextColor));
  }
}
