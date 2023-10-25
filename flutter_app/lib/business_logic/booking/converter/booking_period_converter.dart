import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/utils/logger.dart';

// TODO strategy pattern?
class BookingPeriodConverter {
  final BookingConverter _bookingConverter = BookingConverter();

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

    DateTime startDate = bookingDataModels
        .map((booking) => booking.bookingDate)
        .where((date) => date != null)
        .map((date) => date!)
        .reduce((earliest, date) => date.isBefore(earliest) ? date : earliest);

    DateTime endDate = DateTime.now();

    DateTime currentMonth = DateTime(startDate.year, startDate.month);
    while (currentMonth.isBefore(endDate) || currentMonth.isAtSameMomentAs(endDate)) {
      final monthKey = currentMonth.millisecondsSinceEpoch;

      if (!bookingsByCategory.containsKey(monthKey)) {
        final periodFilter = BudgetPeriodFilter(
          period: BudgetPeriod.month,
          dateTime: currentMonth,
          dateTimeFrom: null,
          dateTimeTo: null,
        );
        models.insert(
          0,
          BudgetPeriodModel(
            periodFilter: periodFilter,
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
          final category = _bookingConverter.findCategory(categories, categoryId);
          final bookings = _bookingConverter.fromDataModels(dataModels, category);
          final amount = _calculateAmount(dataModels);
          groupModels.add(CategoryBookingGroupModel(category: category, bookings: bookings, amount: amount));
        });

        groupModels.sort((a, b) {
          final typeComparison = a.category.categoryType.index.compareTo(b.category.categoryType.index);

          // Sort by amount in descending order
          final amountComparison = b.amount.compareTo(a.amount);

          if (typeComparison != 0) {
            return typeComparison; // First, sort by category type
          } else if (amountComparison != 0) {
            return amountComparison; // If category types are the same, sort by amount
          } else {
            // If both category type and amount are the same, sort by category name
            final nameA = a.category.name ?? "";
            final nameB = b.category.name ?? "";
            return nameA.compareTo(nameB);
          }
        });

        final income = _calculateTotal(groupModels, CategoryType.income);
        final outcome = _calculateTotal(groupModels, CategoryType.outcome);
        final balance = income - outcome;

        final periodFilter = BudgetPeriodFilter(
          period: BudgetPeriod.month,
          dateTime: month,
          dateTimeFrom: null,
          dateTimeTo: null,
        );

        models.insert(
          0,
          BudgetPeriodModel(
            periodFilter: periodFilter,
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
        periodFilter: BudgetPeriodFilter(
          period: BudgetPeriod.all,
          dateTime: DateTime.now(),
          dateTimeFrom: null,
          dateTimeTo: null,
        ),
        income: -1,
        outcome: -1,
        balance: -1,
        categoryBookingGroupModels: [],
      )
    ];
  }
}
