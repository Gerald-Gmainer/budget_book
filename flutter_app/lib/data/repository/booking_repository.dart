import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/data/service/category_cache_service.dart';

class BookingRepository {
  final BookingClient _client = BookingClient();
  late final CategoryCacheService _categoryCacheService;

  BookingRepository() {
    _categoryCacheService = CategoryCacheService(_client);
  }

  Future<List<BookingDataModel>> getAllBookings() async {
    return await _client.getAllBookings();
  }

  Future<List<CategoryModel>> getAllCategories() async {
    return await _categoryCacheService.getAllCategories();
  }

  Future<void> uploadBooking(BookingDataModel model) async {
    await _client.uploadBooking(model);
  }
}
