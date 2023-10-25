import 'package:flutter_app/enum/enum.dart';

class BudgetPeriodFilter {
  final BudgetPeriod period;
  final DateTime? dateTime;
  final DateTime? dateTimeFrom;
  final DateTime? dateTimeTo;

  BudgetPeriodFilter({
    required this.period,
    required this.dateTime,
    required this.dateTimeFrom,
    required this.dateTimeTo,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BudgetPeriodFilter &&
        other.period == period &&
        other.dateTime == dateTime &&
        other.dateTimeFrom == dateTimeFrom &&
        other.dateTimeTo == dateTimeTo;
  }

  @override
  int get hashCode {
    return period.hashCode ^ dateTime.hashCode ^ dateTimeFrom.hashCode ^ dateTimeTo.hashCode;
  }
}
