import 'package:flutter_app/data/data.dart';

class BookingPeriodConverter {
  List<BudgetPeriodModel> convertBookings(BudgetPeriod period, List<BookingModel> bookings) {
    switch (period) {
      case BudgetPeriod.day:
        return _convertToDay(bookings);

      case BudgetPeriod.month:
        return _convertToMonth(bookings);

      case BudgetPeriod.year:
        return _convertToYear(bookings);

      case BudgetPeriod.all:
        return _convertToAll(bookings);
    }
  }

  List<BudgetPeriodModel> _convertToDay(List<BookingModel> bookings) {
    return _convertToAll(bookings);
  }

  List<BudgetPeriodModel> _convertToMonth(List<BookingModel> bookings) {
    return _convertToAll(bookings);
  }

  List<BudgetPeriodModel> _convertToYear(List<BookingModel> bookings) {
    return _convertToAll(bookings);
  }

  List<BudgetPeriodModel> _convertToAll(List<BookingModel> bookings) {
    return [
      BudgetPeriodModel(
        period: BudgetPeriod.all,
        dateTime: DateTime.now(),
        dateTimeFrom: null,
        dateTimeTo: null,
        bookings: bookings,
      )
    ];
  }
}
