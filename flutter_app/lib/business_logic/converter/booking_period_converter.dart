import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/logger.dart';

// TODO strategy pattern?
class BookingPeriodConverter {
  List<BudgetPeriodModel> convertBookings(BudgetPeriod period, List<BookingDataModel> bookings, List<CategoryDataModel> categories) {
    switch (period) {
      case BudgetPeriod.day:
        return _convertToDay(bookings, categories);

      case BudgetPeriod.month:
        return _convertToMonth(bookings, categories);

      case BudgetPeriod.year:
        return _convertToYear(bookings, categories);

      case BudgetPeriod.all:
        return _convertToAll(bookings, categories);
    }
  }

  List<BudgetPeriodModel> _convertToDay(List<BookingDataModel> bookings, List<CategoryDataModel> categories) {
    return _convertToAll(bookings, categories);
  }

  List<BudgetPeriodModel> _convertToMonth(List<BookingDataModel> bookingDataModels, List<CategoryDataModel> categoryDataModels) {
    Map<int, Map<int, List<BookingDataModel>>> bookingsByCategory = {};
    final categories = _convertCategories(categoryDataModels);

    for (var booking in bookingDataModels) {
      if (booking.bookingDate == null || booking.categoryId == null) {
        BudgetLogger.instance.e("_convertToMonth: bookingDate or categoryId is NULL");
        continue;
      }
      final monthKey = DateTime(booking.bookingDate!.year, booking.bookingDate!.month).millisecondsSinceEpoch;
      int categoryId = booking.categoryId!;

      if (!bookingsByCategory.containsKey(monthKey)) {
        bookingsByCategory[monthKey] = {};
      }

      if (!bookingsByCategory[monthKey]!.containsKey(categoryId)) {
        bookingsByCategory[monthKey]![categoryId] = [];
      }

      bookingsByCategory[monthKey]![categoryId]!.add(booking);
    }

    List<BudgetPeriodModel> models = [];
    bookingsByCategory.forEach((monthKey, groupedBookings) {
      final DateTime month = DateTime.fromMillisecondsSinceEpoch(monthKey);
      List<CategoryBookingGroupModel> groupModels = [];

      groupedBookings.forEach((categoryId, dataModels) {
        final category = _findCategory(categories, categoryId);
        final bookings = _convertDataModels(dataModels, category);
        final amount = _calculateAmount(dataModels);
        groupModels.add(CategoryBookingGroupModel(category: category, bookings: bookings, amount: amount));
      });

      groupModels.sort((a, b) {
        final typeComparison = a.category.categoryType.index.compareTo(b.category.categoryType.index);
        final nameA = a.category.dataModel.name ?? "";
        final nameB = b.category.dataModel.name ?? "";
        return typeComparison != 0 ? typeComparison : nameA.compareTo(nameB);
      });

      final balance = _calculateBalance(groupModels);

      models.insert(
        0,
        BudgetPeriodModel(
          period: BudgetPeriod.month,
          dateTime: month,
          dateTimeFrom: null,
          dateTimeTo: null,
          balance: balance,
          categoryBookingGroupModels: groupModels,
        ),
      );
    });

    return models;
  }

  CategoryModel _findCategory(List<CategoryModel> categories, int categoryId) {
    return categories.firstWhere((e) => e.dataModel.id == categoryId);
  }

  double _calculateAmount(List<BookingDataModel> bookings) {
    return bookings.fold(0.0, (double totalAmount, BookingDataModel booking) {
      return totalAmount + (booking.amount ?? 0);
    });
  }

  double _calculateBalance(List<CategoryBookingGroupModel> groupModels) {
    double balance = 0.0;
    for (var model in groupModels) {
      if (model.category.categoryType == CategoryType.income) {
        balance += model.amount;
      } else if (model.category.categoryType == CategoryType.outcome) {
        balance -= model.amount;
      }
    }
    return balance;
  }

  List<BudgetPeriodModel> _convertToYear(List<BookingDataModel> bookings, List<CategoryDataModel> categories) {
    return _convertToAll(bookings, categories);
  }

  List<BudgetPeriodModel> _convertToAll(List<BookingDataModel> bookings, List<CategoryDataModel> categories) {
    return [
      BudgetPeriodModel(
        period: BudgetPeriod.all,
        dateTime: DateTime.now(),
        dateTimeFrom: null,
        dateTimeTo: null,
        balance: -1,
        categoryBookingGroupModels: [],
      )
    ];
  }

  List<BookingModel> _convertDataModels(List<BookingDataModel> dataModels, CategoryModel categoryModel) {
    return dataModels
        .map(
          (e) => BookingModel(
            dataModel: e,
            categoryType: categoryModel.categoryType,
          ),
        )
        .toList();
  }

  List<CategoryModel> _convertCategories(List<CategoryDataModel> dataModels) {
    return dataModels.map((e) => CategoryModel(e, e.categoryType)).toList();
  }
}
