import 'package:flutter_app/data/data.dart';

class BookingRepository {
  final BookingClient _client = BookingClient();
  final CategoryClient _categoryClient = CategoryClient();
  late final CategoryCacheService _categoryCacheService;
  late final IconCacheService _iconCacheService;

  BookingRepository() {
    _categoryCacheService = CategoryCacheService(_categoryClient);
    _iconCacheService = IconCacheService(_categoryClient);
  }

  Future<List<BookingDataModel>> getAllBookings() async {
    return await _client.getAllBookings();
  }

  Future<List<CategoryDataModel>> getAllCategories({bool forceReload = false}) async {
    return await _categoryCacheService.getAllCategories(forceReload);
  }

  Future<IconCacheModel> getIconCache() async {
    return await _iconCacheService.getIconCache();
  }

  Future<void> createBooking(BookingDataModel model) async {
    await _client.uploadBooking(model);
  }

  Future<void> createCategory(CategoryDataModel model) async {
    await _client.createCategory(model);
  }
}
