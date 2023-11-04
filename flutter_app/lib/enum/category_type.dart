import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';

enum CategoryType {
  income,
  outcome,
}

extension CategoryTypeColor on CategoryType {
  String get text {
    switch (this) {
      case CategoryType.income:
        return "booking.income_type";
      case CategoryType.outcome:
        return "booking.outcome_type";
    }
  }

  Color get color {
    switch (this) {
      case CategoryType.income:
        return AppColors.incomeColor;
      case CategoryType.outcome:
        return AppColors.outcomeColor;
    }
  }
}
