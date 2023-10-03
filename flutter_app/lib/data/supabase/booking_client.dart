import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';

class BookingClient {
  Future<List<BookingDataModel>> getAllBookings() async {
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase
        .from('view_bookings')
        .select('id, booking_date, description, amount, category_id, account_id, is_deleted')
        .order('booking_date', ascending: true);
    BudgetLogger.instance.d("view_bookings took ${stopwatch.elapsed.inMilliseconds} ms");
    return List.from(response).map((item) => BookingDataModel.fromJson(item)).toList();
  }

  Future<List<CategoryDataModel>> getAllCategories() async {
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase.from('view_categories').select('id, name, type').order('name', ascending: true);
    BudgetLogger.instance.d("view_categories took ${stopwatch.elapsed.inMilliseconds} ms");
    return List.from(response).map((item) => CategoryDataModel.fromJson(item)).toList();
  }

  Future<void> uploadBooking(BookingDataModel model) async {
    // TODO upload account id
    Stopwatch stopwatch = Stopwatch()..start();
    await supabase.rpc("create_booking", params: {"p_booking": model.toJson()});
    BudgetLogger.instance.d("uploadBooking took ${stopwatch.elapsed.inMilliseconds} ms");
  }
}
