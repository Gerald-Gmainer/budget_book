import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CurrencyText extends StatelessWidget {
  final double? value;
  final TextStyle? style;

  const CurrencyText({required this.value, this.style});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadedState) {
          return _buildText(state.profileSetting.currency);
        }
        return _buildText(null);
      },
    );
  }

  Widget _buildText(CurrencyModel? currencyModel) {
    if (currencyModel != null) {
      final int decimalPrecision = currencyModel.decimalPrecision;
      final bool isUnitPositionFront = currencyModel.isUnitPositionFront;
      final String symbol = currencyModel.symbol;

      String formattedValue = (value ?? 0).toStringAsFixed(decimalPrecision);
      final pattern = isUnitPositionFront ? '\u00A4#,##0.00' : '#,##0.00\u00A4';
      final formatCurrency = NumberFormat.currency(
        locale: 'de_DE',
        customPattern: pattern,
        symbol: symbol,
      );
      formattedValue = formatCurrency.format(value);

      return Text(
        formattedValue,
        style: style,
      );
    } else {
      return Text(
        (value ?? 0).toStringAsFixed(0),
        style: style,
      );
    }
  }
}
