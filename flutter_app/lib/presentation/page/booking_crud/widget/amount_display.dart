import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/app_colors.dart';
import 'package:flutter_app/utils/logger.dart';

class AmountDisplay extends StatelessWidget {
  final CalculatorModel model;

  const AmountDisplay({required this.model});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildHistory(),
            _buildResult(),
          ],
        ),
      ),
    );
  }

  Widget _buildHistory() {
    return ValueListenableBuilder<List<CalculatorKey>>(
      valueListenable: model.history,
      builder: (context, data, child) {
        final history = data.map((e) => e.calculateText).toList().join();
        return Text(history, style: const TextStyle(fontSize: 26, color: AppColors.primaryTextColor));
      },
    );
  }

  Widget _buildResult() {
    return ValueListenableBuilder<double>(
      valueListenable: model.result,
      builder: (context, data, child) {
        final result = data == data.truncate() ? data.toStringAsFixed(0) : data.toStringAsFixed(2);
        return Text(result, style: const TextStyle(fontSize: 44, color: AppColors.primaryTextColor));
      },
    );
  }
}
