import 'package:flutter_app/data/data.dart';

class BookingCrudModel {
  final BookingModel model;
  final CategoryType categoryType;

  BookingCrudModel({required this.model, required this.categoryType});

  @override
  String toString() {
    return "categoryType: $categoryType / model: $model";
  }
}
