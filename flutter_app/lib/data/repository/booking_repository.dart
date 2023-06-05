import 'package:flutter_app/data/data.dart';

class BookingRepository {
  final BookingClient _client = BookingClient();

  Future<List<BookingModel>> getAllBookings() async {
    return await _client.getAllBookings();
  }

  Future<List<CategoryModel>> getAllCategories() async {
    return await _client.getAllCategories();
  }
}
