import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/logger.dart';

class BookingPeriodConverter {
  List<BudgetPeriodModel> convertBookings(BudgetPeriod period, List<BookingModel> bookings, List<CategoryModel> categories) {
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

  List<BudgetPeriodModel> _convertToDay(List<BookingModel> bookings, List<CategoryModel> categories) {
    return _convertToAll(bookings, categories);
  }

  List<BudgetPeriodModel> _convertToMonth(List<BookingModel> bookings, List<CategoryModel> categories) {
    Map<int, Map<int, List<BookingModel>>> bookingsByCategory = {};

    for (var booking in bookings) {
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

      groupedBookings.forEach((categoryId, bookings) {
        final category = _findCategory(categories, categoryId);
        groupModels.add(CategoryBookingGroupModel(category: category, bookings: bookings));
      });

      groupModels.sort((a, b) {
        final typeComparison = a.category.categoryType.index.compareTo(b.category.categoryType.index);

        if (typeComparison == 0) {
          return a.category.name.compareTo(b.category.name);
        } else {
          return typeComparison;
        }
      });

      models.insert(
        0,
        BudgetPeriodModel(
          period: BudgetPeriod.month,
          dateTime: month,
          dateTimeFrom: null,
          dateTimeTo: null,
          categoryBookingGroupModels: groupModels,
        ),
      );
    });

    return models;
  }

  CategoryModel _findCategory(List<CategoryModel> categories, int categoryId) {
    return categories.firstWhere((element) => element.id == categoryId, orElse: () => CategoryModel(name: "unkown", categoryType: CategoryType.outcome));
  }

  List<BudgetPeriodModel> _convertToYear(List<BookingModel> bookings, List<CategoryModel> categories) {
    return _convertToAll(bookings, categories);
  }

  List<BudgetPeriodModel> _convertToAll(List<BookingModel> bookings, List<CategoryModel> categories) {
    return [
      BudgetPeriodModel(
        period: BudgetPeriod.all,
        dateTime: DateTime.now(),
        dateTimeFrom: null,
        dateTimeTo: null,
        categoryBookingGroupModels: [],
      )
    ];
  }
}
