import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/enum.dart';

class BookingModel {
  int? id;
  DateTime? bookingDate;
  String? description;
  double amount;
  CategoryModel? category;
  AccountModel? account;
  bool isDeleted;
  CategoryType categoryType;

  BookingModel.empty()
      : id = null,
        amount = 0,
        isDeleted = false,
        categoryType = CategoryType.outcome;

  BookingModel({
    required this.id,
    required this.bookingDate,
    required this.description,
    required this.amount,
    required this.category,
    required this.account,
    required this.isDeleted,
    required this.categoryType,
  });

  @override
  String toString() {
    return "BookingModel id: $id /  bookingDate: $bookingDate / amount: $amount / category: $category / account: $account / categoryType: $categoryType ";
  }
}
