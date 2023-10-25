import 'package:flutter_app/data/data.dart';

class BookingDataModel extends DataModel {
  DateTime? bookingDate;
  String? description;
  double? amount;
  int? categoryId;
  int? accountId;
  bool? isDeleted;

  BookingDataModel({
    int? id,
    required this.bookingDate,
    required this.description,
    required this.amount,
    required this.categoryId,
    required this.accountId,
    required this.isDeleted,
  }) : super(id);

  factory BookingDataModel.fromJson(Map<String, dynamic> json) => BookingDataModel(
        id: json['id'],
        bookingDate: JsonDecoder.decodeDateTime(json['booking_date'])!,
        description: json['description'],
        amount: json['amount'],
        categoryId: json['category_id'],
        accountId: json['account_id'],
        isDeleted: json['is_deleted'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'booking_date': JsonEncoder.encodeDateTime(bookingDate),
      'description': description,
      'amount': amount,
      'category_id': categoryId,
      'account_id': accountId,
      // 'is_deleted': isDeleted,
    };
  }

  @override
  String toString() {
    return [
      "id: $id",
      "bookingDate: $bookingDate",
      "description: $description",
      "amount: $amount",
      "categoryId: $categoryId",
      // "accountId: $accountId",
      // "isDeleted: $isDeleted",
    ].join(" / ");
  }
}
