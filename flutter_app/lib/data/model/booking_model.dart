import 'package:flutter_app/data/data.dart';

class BookingModel extends DataModel {
  DateTime? bookingDate;
  String? description;
  double? amount;
  int? categoryId;
  int? accountId;
  bool? isDeleted;

  BookingModel.empty() : super(null);

  BookingModel({
    int? id,
    required this.bookingDate,
    required this.description,
    required this.amount,
    required this.categoryId,
    required this.accountId,
    required this.isDeleted,
  }) : super(id);

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json['id'],
        bookingDate: JsonDecoder.decodeDateTime(json['booking_date'])!,
        description: json['description'],
        amount: json['amount'],
        categoryId: json['category_id'],
        accountId: json['account_id'],
        isDeleted: json['is_deleted'],
      );

  @override
  String toString() {
    return [
      "id: $id",
      "bookingDate: $bookingDate",
      // "description: $description",
      "amount: $amount",
      "categoryId: $categoryId",
      // "accountId: $accountId",
      // "isDeleted: $isDeleted",
    ].join(" / ");
  }
}
