import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
      data = [_PieData(" ", 100, " ", AppColors.secondaryColor, null)];
    } else {
      data = _mapToPieData(periodModel.outcome, periodModel.categoryBookingGroupModels);
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
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
              final pieData = data as _PieData;
              if (pieData.icon != null) {
                return Icon(IconConverter.getIconFromString(pieData.icon));
              } else {
                return SizedBox.shrink();
              }
            },
            // useSeriesColor: true,
          ),
          strokeColor: AppColors.primaryColor,
          strokeWidth: 4),
    ];
  }

  List<_PieData> _mapToPieData(double totalOutcome, List<CategoryBookingGroupModel> models) {
    List<_PieData> pieDataList = [];

    for (CategoryBookingGroupModel model in models) {
      if (model.category.categoryType == CategoryType.income) {
        continue;
      }
      String categoryName = model.category.name ?? "unknown";
      bool hideIcon = model.amount / totalOutcome < 0.05;
      _PieData pieData = _PieData(
        categoryName,
        model.amount,
        model.category.name ?? "unknown",
        ColorConverter.iconColorToColor(model.category.iconColor),
        hideIcon ? null : model.category.iconData?.name,
      );
      pieDataList.add(pieData);
    }
    return pieDataList;
  }
}

class _PieData {
  _PieData(this.xData, this.yData, this.text, this.color, this.icon);
  final String xData;
  final num yData;
  final String? text;
  final Color color;
  final String? icon;
}
