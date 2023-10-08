import 'package:flutter_app/data/data.dart';

class BookingModel {
  final BookingDataModel dataModel;
  CategoryType categoryType;

  BookingModel.empty()
      : dataModel = BookingDataModel.empty(),
        categoryType = CategoryType.outcome;

  BookingModel({required this.dataModel, required this.categoryType});

  @override
  String toString() {
    return "categoryType: $categoryType / model: $dataModel";
  }
}
