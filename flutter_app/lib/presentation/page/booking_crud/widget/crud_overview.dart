import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class CrudOverview extends StatelessWidget {
  final BookingModel model;

  const CrudOverview({required this.model});

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return AnimatedSize(
      duration: Duration(milliseconds: 100),
      child: SizedBox(
        height: keyboardIsOpen ? 0.0 : null,
        child: _buildView(),
      ),
    );
  }

  Widget _buildView() {
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
              // if (_hasDescription()) const SizedBox(height: AppDimensions.verticalPadding),
              // if (_hasDescription()) _buildNote(),
            ],
          ),
        ),
      ),
    );
  }

  _hasDescription() {
    return model.description != null && model.description!.isNotEmpty;
  }

  _buildDate() {
    return Text(
      DateTimeConverter.toEEEEdMMMM(model.bookingDate),
      style: const TextStyle(color: AppColors.primaryTextColor, fontSize: 16),
    );
  }

  _buildAmount() {
    return CurrencyText(value: model.amount, style: const TextStyle(fontSize: 38, color: AppColors.primaryTextColor));
  }

  _buildNote() {
    return Text(
      model.description ?? "",
      style: const TextStyle(color: AppColors.primaryTextColor, fontSize: 16),
    );
  }
}
