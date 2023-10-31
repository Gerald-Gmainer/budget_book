import 'package:flutter_app/data/data.dart';

class BookingRepository {
  final BookingClient _client = BookingClient();
  final CategoryClient _categoryClient = CategoryClient();
  late final CategoryCacheService _categoryCacheService;
  late final IconCacheService _iconCacheService;
  late final SuggestionCacheService _suggestionCacheService;
  late final AccountCacheService _accountCacheService;

  BookingRepository() {
    _categoryCacheService = CategoryCacheService(_categoryClient);
    _iconCacheService = IconCacheService(_categoryClient);
    _suggestionCacheService = SuggestionCacheService(_client);
    _accountCacheService = AccountCacheService(_client);
  }

  Future<void> checkToken() async {
    await _client.checkToken();
  }

  Future<List<BookingDataModel>> getAllBookings() async {
    return await _client.getAllBookings();
  }

  Future<List<CategoryDataModel>> getAllCategories({bool forceReload = false}) async {
    return await _categoryCacheService.getData(forceReload: forceReload);
  }

  Future<IconCacheModel> getIconCache() async {
    return await _iconCacheService.getData();
  }

  Future<void> createBooking(BookingDataModel model) async {
    await _client.createBooking(model);
  }

  Future<void> updateBooking(BookingDataModel model) async {
    await _client.updateBooking(model);
  }

  Future<List<String>> getSuggestions({bool forceReload = false}) async {
    return _suggestionCacheService.getData(forceReload: forceReload);
  }

  Future<void> deleteBooking(int id) async {
    await _client.deleteBooking(id);
  }

  Future<void> createCategory(CategoryDataModel model) async {
    await _client.createCategory(model);
  }

  Future<void> editCategory(CategoryDataModel model) async {
    await _client.updateCategory(model);
  }

  Future<void> deleteCategory(int id) async {
    await _client.deleteCategory(id);
  }

  Future<List<AccountDataModel>> getAccounts({bool forceReload = false}) async {
    return await _accountCacheService.getData(forceReload: forceReload);
  }
}
