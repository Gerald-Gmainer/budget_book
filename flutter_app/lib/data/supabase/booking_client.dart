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

  Future<void> createBooking(BookingDataModel model) async {
    await checkToken();
    // TODO upload account id
    Stopwatch stopwatch = Stopwatch()..start();
    await supabase.rpc("create_booking", params: {"p_booking": model.toJson()});
    BudgetLogger.instance.d("createBooking took ${stopwatch.elapsed.inMilliseconds} ms");
  }

  Future<void> updateBooking(BookingDataModel model) async {
    await checkToken();
    // TODO upload account id
    Stopwatch stopwatch = Stopwatch()..start();
    await supabase.rpc("update_booking", params: {"p_booking": model.toJson()});
    BudgetLogger.instance.d("updateBooking took ${stopwatch.elapsed.inMilliseconds} ms");
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

  Future<void> createCategory(CategoryDataModel model) async {
    await checkToken();
    Stopwatch stopwatch = Stopwatch()..start();
    BudgetLogger.instance.d("create_category: ${model.toJson()}");
    await supabase.rpc("create_category", params: {"p_category": model.toJson()});
    BudgetLogger.instance.d("createCategory took ${stopwatch.elapsed.inMilliseconds} ms");
  }

  Future<void> updateCategory(CategoryDataModel model) async {
    await checkToken();
    Stopwatch stopwatch = Stopwatch()..start();
    BudgetLogger.instance.d("update_category: ${model.toJson()}");
    await supabase.rpc("update_category", params: {"p_category": model.toJson()});
    BudgetLogger.instance.d("editCategory took ${stopwatch.elapsed.inMilliseconds} ms");
  }

  Future<void> deleteCategory(int id) async {
    await checkToken();
    Stopwatch stopwatch = Stopwatch()..start();
    await supabase.rpc("delete_category", params: {"p_id": id});
    BudgetLogger.instance.d("deleteCategory took ${stopwatch.elapsed.inMilliseconds} ms");
  }
}
