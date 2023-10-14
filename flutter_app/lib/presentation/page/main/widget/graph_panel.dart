import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'balance_text.dart';
import 'total_text.dart';

class GraphPanel extends StatelessWidget {
  final BudgetPeriodModel periodModel;

  const GraphPanel({required this.periodModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 250,
        child: SfCircularChart(
          // margin: EdgeInsets.zero,
          annotations: <CircularChartAnnotation>[
            CircularChartAnnotation(
              widget: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TotalText(periodModel: periodModel, categoryType: CategoryType.income),
                    TotalText(periodModel: periodModel, categoryType: CategoryType.outcome),
                  ],
                ),
              ),
            )
          ],
          series: _generateSeries(),
        ),
      ),
    );
  }

  List<CircularSeries<dynamic, dynamic>>? _generateSeries() {
    List<_PieData> data;
    if (periodModel.categoryBookingGroupModels.isEmpty) {
      data =  [_PieData(" ", 100, " ", AppColors.secondaryColor)];
    }
    else {
      data = _mapToPieData(periodModel.categoryBookingGroupModels);
    }
    return <CircularSeries<_PieData, String>>[
      DoughnutSeries<_PieData, String>(
          dataSource: data,
          animationDuration: periodModel.categoryBookingGroupModels.isEmpty ? 0 : 1000,
          animationDelay: 100,
          xValueMapper: (_PieData data, _) => data.xData,
          yValueMapper: (_PieData data, _) => data.yData,
          dataLabelMapper: (_PieData data, _) => data.text,
          pointColorMapper: (_PieData data, _) => data.color,
          radius: '100%',
          innerRadius: '60%',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          strokeColor: AppColors.primaryColor,
          strokeWidth: 4),
    ];
  }

  List<_PieData> _mapToPieData(List<CategoryBookingGroupModel> models) {
    List<_PieData> pieDataList = [];

    for (var model in models) {
      if (model.category.categoryType == CategoryType.income) {
        continue;
      }
      String categoryName = model.category.name ?? "unknown";
      double totalAmount = 0.0;
      for (var booking in model.bookings) {
        if (booking.dataModel.amount != null) {
          totalAmount += booking.dataModel.amount!;
        }
      }
      _PieData pieData = _PieData(
        categoryName,
        totalAmount,
        model.category.name ?? "unknown",
        ColorConverter.iconColorToColor(model.category.iconColor),
      );
      pieDataList.add(pieData);
    }
    return pieDataList;
  }
}

class _PieData {
  _PieData(this.xData, this.yData, this.text, this.color);
  final String xData;
  final num yData;
  final String? text;
  final Color color;
}
