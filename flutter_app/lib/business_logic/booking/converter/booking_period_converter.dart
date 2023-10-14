import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/utils/logger.dart';

// TODO strategy pattern?
class BookingPeriodConverter {
  List<BudgetPeriodModel> convertBookings(BudgetPeriod period, List<BookingDataModel> bookings, List<CategoryModel> categories) {
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

  List<BudgetPeriodModel> _convertToDay(List<BookingDataModel> bookings, List<CategoryModel> categories) {
    return _convertToAll(bookings, categories);
  }

  List<BudgetPeriodModel> _convertToMonth(List<BookingDataModel> bookingDataModels, List<CategoryModel> categories) {
    Map<int, Map<int, List<BookingDataModel>>> bookingsByCategory = {};

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
    // bookingsByCategory.forEach((monthKey, groupedBookings) {
    //   final DateTime month = DateTime.fromMillisecondsSinceEpoch(monthKey);
    //   List<CategoryBookingGroupModel> groupModels = [];
    //
    //   groupedBookings.forEach((categoryId, dataModels) {
    //     final category = _findCategory(categories, categoryId);
    //     final bookings = _convertDataModels(dataModels, category);
    //     final amount = _calculateAmount(dataModels);
    //     groupModels.add(CategoryBookingGroupModel(category: category, bookings: bookings, amount: amount));
    //   });
    //
    //   groupModels.sort((a, b) {
    //     final typeComparison = a.category.categoryType.index.compareTo(b.category.categoryType.index);
    //     final nameA = a.category.name ?? "";
    //     final nameB = b.category.name ?? "";
    //     return typeComparison != 0 ? typeComparison : nameA.compareTo(nameB);
    //   });
    //
    //   final income = _calculateTotal(groupModels, CategoryType.income);
    //   final outcome = _calculateTotal(groupModels, CategoryType.outcome);
    //   final balance = income - outcome;
    //
    //   models.insert(
    //     0,
    //     BudgetPeriodModel(
    //       period: BudgetPeriod.month,
    //       dateTime: month,
    //       dateTimeFrom: null,
    //       dateTimeTo: null,
    //       income: income,
    //       outcome: outcome,
    //       balance: balance,
    //       categoryBookingGroupModels: groupModels,
    //     ),
    //   );
    // });

    DateTime startDate = bookingDataModels
        .map((booking) => booking.bookingDate)
        .where((date) => date != null)
        .map((date) => date!)
        .reduce((earliest, date) => date.isBefore(earliest) ? date : earliest);

    DateTime endDate = DateTime.now();

    DateTime currentMonth = DateTime(startDate.year, startDate.month);
    while (currentMonth.isBefore(endDate) || currentMonth.isAtSameMomentAs(endDate)) {
      final monthKey = currentMonth.millisecondsSinceEpoch;

      // Check if there are bookings for this month
      if (!bookingsByCategory.containsKey(monthKey)) {
        models.insert(
          0,
          BudgetPeriodModel(
            period: BudgetPeriod.month,
            dateTime: currentMonth,
            dateTimeFrom: null,
            dateTimeTo: null,
            income: 0,
            outcome: 0,
            balance: 0,
            categoryBookingGroupModels: [],
          ),
        );
      } else {
        final DateTime month = DateTime.fromMillisecondsSinceEpoch(monthKey);
        List<CategoryBookingGroupModel> groupModels = [];

        bookingsByCategory[monthKey]?.forEach((categoryId, dataModels) {
          final category = _findCategory(categories, categoryId);
          final bookings = _convertDataModels(dataModels, category);
          final amount = _calculateAmount(dataModels);
          groupModels.add(CategoryBookingGroupModel(category: category, bookings: bookings, amount: amount));
        });

        groupModels.sort((a, b) {
          final typeComparison = a.category.categoryType.index.compareTo(b.category.categoryType.index);
          final nameA = a.category.name ?? "";
          final nameB = b.category.name ?? "";
          return typeComparison != 0 ? typeComparison : nameA.compareTo(nameB);
        });

        final income = _calculateTotal(groupModels, CategoryType.income);
        final outcome = _calculateTotal(groupModels, CategoryType.outcome);
        final balance = income - outcome;

        models.insert(
          0,
          BudgetPeriodModel(
            period: BudgetPeriod.month,
            dateTime: month,
            dateTimeFrom: null,
            dateTimeTo: null,
            income: income,
            outcome: outcome,
            balance: balance,
            categoryBookingGroupModels: groupModels,
          ),
        );
      }
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    }

    return models;
  }

  CategoryModel _findCategory(List<CategoryModel> categories, int categoryId) {
    return categories.firstWhere((e) => e.id == categoryId);
  }

  double _calculateAmount(List<BookingDataModel> bookings) {
    return bookings.fold(0.0, (double totalAmount, BookingDataModel booking) {
      return totalAmount + (booking.amount ?? 0);
    });
  }

  double _calculateTotal(List<CategoryBookingGroupModel> groupModels, CategoryType categoryType) {
    double total = 0.0;
    for (var model in groupModels) {
      if (model.category.categoryType == categoryType) {
        total += model.amount;
      }
    }
    return total;
  }

  List<BudgetPeriodModel> _convertToYear(List<BookingDataModel> bookings, List<CategoryModel> categories) {
    return _convertToAll(bookings, categories);
  }

  List<BudgetPeriodModel> _convertToAll(List<BookingDataModel> bookings, List<CategoryModel> categories) {
    return [
      BudgetPeriodModel(
        period: BudgetPeriod.all,
        dateTime: DateTime.now(),
        dateTimeFrom: null,
        dateTimeTo: null,
        income: -1,
        outcome: -1,
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
}
