import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';

import 'base/base_client.dart';

class BookingClient extends BaseClient {
  Future<List<BookingDataModel>> getAllBookings() async {
    await checkToken();
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase
        .from('view_bookings')
        .select('id, booking_date, description, amount, category_id, account_id, is_deleted')
        .order('booking_date', ascending: true);
    BudgetLogger.instance.d("view_bookings took ${stopwatch.elapsed.inMilliseconds} ms");
    return List.from(response).map((item) => BookingDataModel.fromJson(item)).toList();
  }

  Future<void> upsertBooking(BookingDataModel model) async {
    await checkToken();
    Stopwatch stopwatch = Stopwatch()..start();
    BudgetLogger.instance.d("upsert booking ${model.toJson()}");
    await supabase.rpc("upsert_booking", params: {"p_booking": model.toJson()});
    BudgetLogger.instance.d("upsert_booking took ${stopwatch.elapsed.inMilliseconds} ms");
  }

  Future<List<String>> getSuggestions() async {
    await checkToken();
    final profileId = getProfileId();
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase.from('mat_view_suggestions_$profileId').select('id, description').order('description', ascending: true);
    BudgetLogger.instance.d("mat_view_suggestions_$profileId took ${stopwatch.elapsed.inMilliseconds} ms");
    List<String> descriptions = [];
    for (var item in response) {
      if (item['description'] is String) {
        descriptions.add(item['description']);
      } else {
        descriptions.add(item['description'].toString());
      }
    }
    return descriptions;
  }

  Future<void> deleteBooking(int id) async {
    await checkToken();
    Stopwatch stopwatch = Stopwatch()..start();
    await supabase.rpc("delete_booking", params: {"p_id": id});
    BudgetLogger.instance.d("deleteBooking took ${stopwatch.elapsed.inMilliseconds} ms");
  }

}
