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

    // for (var booking in bookings) {
    //   final monthKey = DateTime(booking.bookingDate.year, booking.bookingDate.month);
    //   if (bookingsByMonth.containsKey(monthKey.millisecondsSinceEpoch)) {
    //     bookingsByMonth[monthKey.millisecondsSinceEpoch]!.add(booking);
    //   } else {
    //     bookingsByMonth[monthKey.millisecondsSinceEpoch] = [booking];
    //   }
    // }
    for (var booking in bookings) {
      final monthKey = DateTime(booking.bookingDate.year, booking.bookingDate.month).millisecondsSinceEpoch;
      int categoryId = booking.categoryId;

      if (!bookingsByCategory.containsKey(monthKey)) {
        bookingsByCategory[monthKey] = {};
      }

      if (!bookingsByCategory[monthKey]!.containsKey(categoryId)) {
        bookingsByCategory[monthKey]![categoryId] = [];
      }

      bookingsByCategory[monthKey]![categoryId]!.add(booking);
    }

    // Map<int, Map<int, List<BookingModel>>> bookingsByCategory = {};

    // for (var monthMap in bookingsByMonth.values.toList()) {
    // bookingsByMonth.forEach((monthKey, bookings) {
    //   bookingsByCategory[monthKey].add(monthMap);
    //
    //   for (var booking in monthMap) {
    //     final categoryId = booking.categoryId;
    //     if (bookingsByCategory.containsKey(categoryId)) {
    //       bookingsByMonth[categoryId]!.add(booking);
    //     } else {
    //       // final categoryBookingGroup = CategoryBookingGroupModel(category, booking);
    //       // bookingsByCategory[categoryId] = {booking.bookingDate.month: categoryBookingGroup};
    //       bookingsByMonth[categoryId] = [booking];
    //     }
    //   }
    // });

    List<BudgetPeriodModel> models = [];
    bookingsByCategory.forEach((monthKey, groupedBookings) {
      final DateTime month = DateTime.fromMillisecondsSinceEpoch(monthKey);
      List<CategoryBookingGroupModel> groupModels = [];

      groupedBookings.forEach((categoryId, bookings) {
        final category = _findCategory(categories, categoryId);
        groupModels.add(CategoryBookingGroupModel(category: category, bookings: bookings));
      });

      // final groupmodel = CategoryBookingGroupModel(
      //   final CategoryModel category;
      //   List<BookingModel> bookings = [];
      // );

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
