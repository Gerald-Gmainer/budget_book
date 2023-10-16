import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';

enum CategoryType {
  income,
  outcome,
}

extension CategoryTypeColor on CategoryType {
  Color get color {
    switch (this) {
      case CategoryType.income:
        return AppColors.incomeColor;
      case CategoryType.outcome:
        return AppColors.outcomeColor;
    }
  }
}