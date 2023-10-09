import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/data/service/category_cache_service.dart';
import 'package:flutter_app/data/service/icon_cache_service.dart';

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

  Future<List<CategoryDataModel>> getAllCategories() async {
    return await _categoryCacheService.getAllCategories();
  }

  Future<IconCacheModel> getIconCache() async {
    return await _iconCacheService.getIconCache();
  }

  Future<void> uploadBooking(BookingDataModel model) async {
    await _client.uploadBooking(model);
  }
}
