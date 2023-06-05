import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/logger.dart';

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
    Map<int, List<BookingModel>> bookingsByMonth = {};

    for (var booking in bookings) {
      final monthKey = DateTime(booking.bookingDate.year, booking.bookingDate.month);
      if (bookingsByMonth.containsKey(monthKey.millisecondsSinceEpoch)) {
        bookingsByMonth[monthKey.millisecondsSinceEpoch]!.add(booking);
      } else {
        bookingsByMonth[monthKey.millisecondsSinceEpoch] = [booking];
      }
    }

    List<BudgetPeriodModel> models = [];
    bookingsByMonth.forEach((monthKey, bookings) {
      final DateTime month = DateTime.fromMillisecondsSinceEpoch(monthKey);

      models.insert(
        0,
        BudgetPeriodModel(
          period: BudgetPeriod.month,
          dateTime: month,
          dateTimeFrom: null,
          dateTimeTo: null,
          bookings: bookings,
        ),
      );
    });

    return models;

    return models;
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
