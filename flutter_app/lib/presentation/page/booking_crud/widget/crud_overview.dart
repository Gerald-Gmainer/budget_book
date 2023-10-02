import 'package:flutter/material.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class CrudOverview extends StatelessWidget {
  final BookingCrudModel model;

  const CrudOverview({required this.model});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.horizontalPadding, vertical: AppDimensions.verticalPadding),
          child: Column(
            children: [
              _buildDate(),
              const SizedBox(height: AppDimensions.verticalPadding),
              _buildAmount(),
              if (_hasDescription()) const SizedBox(height: AppDimensions.verticalPadding),
              if (_hasDescription()) _buildNote(),
            ],
          ),
        ),
      ),
    );
  }

  _hasDescription() {
    return model.bookingModel.description != null && model.bookingModel.description!.isNotEmpty;
  }

  _buildDate() {
    return Text(
      DateTimeConverter.toEEEEdMMMM(model.bookingModel.bookingDate),
      style: const TextStyle(color: AppColors.primaryTextColor, fontSize: 16),
    );
  }

  _buildAmount() {
    double result = model.bookingModel.amount ?? 0;
    String resultFormatted = result == result.truncate() ? result.toStringAsFixed(0) : result.toStringAsFixed(2);
    return Text("€$resultFormatted", style: const TextStyle(fontSize: 38, color: AppColors.primaryTextColor));
  }

  _buildNote() {
    return Text(
      model.bookingModel.description ?? "",
      style: const TextStyle(color: AppColors.primaryTextColor, fontSize: 16),
    );
  }
}