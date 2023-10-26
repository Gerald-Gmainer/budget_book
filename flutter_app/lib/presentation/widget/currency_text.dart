import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CurrencyText extends StatelessWidget {
  static const double defaultFontSize = 14;
  final double? value;
  final TextStyle style;
  final bool showSymbol;

  const CurrencyText({
    required this.value,
    this.style = const TextStyle(fontSize: defaultFontSize),
    this.showSymbol = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadedState) {
          return _buildText(context, state.profile.currency);
        }
        return _buildDefaultText(context);
      },
    );
  }

  Widget _buildText(BuildContext context, CurrencyModel currencyModel) {
    final int decimalPrecision = currencyModel.decimalPrecision;
    final bool isUnitPositionFront = currencyModel.isUnitPositionFront;
    final String symbol = currencyModel.symbol;
    final decimalSeparator = _getDecimalSeparator(context);
    final groupSeparator = _getGroupSeparator(context);

    final String formattedValue = (value ?? 0).toStringAsFixed(decimalPrecision);
    final List<String> parts = formattedValue.split('.');
    final RegExp regExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final String integerPart = parts[0].replaceAllMapped(regExp, (Match match) {
      return '${match[1]}$groupSeparator';
    });
    final String decimalPart = parts.length > 1 ? decimalSeparator + parts[1] : '';

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          if (showSymbol && isUnitPositionFront) TextSpan(text: "$symbol ", style: style),
          TextSpan(text: integerPart, style: style),
          TextSpan(
            text: decimalPart,
            style: style.copyWith(fontSize: (style.fontSize ?? defaultFontSize) - 4.0),
          ),
          if (showSymbol && !isUnitPositionFront) TextSpan(text: " $symbol", style: style),
        ],
      ),
    );
  }

  Widget _buildDefaultText(BuildContext context) {
    return Text((value ?? 0).toStringAsFixed(0), style: style);
  }

  String _getDecimalSeparator(BuildContext context) {
    // final locale = Localizations.localeOf(context);
    const locale = "de_DE";
    final format = NumberFormat.decimalPattern(locale);
    return format.symbols.DECIMAL_SEP;
  }

  String _getGroupSeparator(BuildContext context) {
    // final locale = Localizations.localeOf(context);
    const locale = "de_DE";
    final format = NumberFormat.decimalPattern(locale);
    return format.symbols.GROUP_SEP;
  }
}
