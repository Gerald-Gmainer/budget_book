import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';

class BookingConverter {
  List<BookingModel> fromDataModels(List<BookingDataModel> dataModels, CategoryModel categoryModel) {
    return dataModels
        .map(
          (e) => BookingModel(
            id: e.id,
            bookingDate: e.bookingDate,
            description: e.description,
            amount: e.amount ?? 0,
            category: categoryModel,
            account: null,
            isDeleted: e.isDeleted ?? false,
            categoryType: categoryModel.categoryType,
          ),
        )
        .toList();
  }

  CategoryModel findCategory(List<CategoryModel> categories, int categoryId) {
    return categories.firstWhere((e) => e.id == categoryId);
  }

  BookingDataModel toDataModel(BookingModel model) {
    return BookingDataModel(
      id: model.id,
      bookingDate: model.bookingDate,
      description: model.description,
      amount: model.amount,
      categoryId: model.category?.id,
      accountId: model.account?.id,
      isDeleted: model.isDeleted,
    );
  }
}
