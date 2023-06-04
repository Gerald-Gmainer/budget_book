import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';

class BookingClient {
  Future<List<BookingModel>> getAllBookings() async {
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase
        .from('view_bookings')
        .select('id, booking_date, description, amount, category_id, account_id, is_deleted')
        .order('booking_date', ascending: false);
    BudgetLogger.instance.d("view_bookings took ${stopwatch.elapsed.inMilliseconds} ms");
    return List.from(response).map((item) => BookingModel.fromJson(item)).toList();
  }
}
