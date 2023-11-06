import 'package:flutter_app/data/data.dart';

class BookingRepository {
  final BookingClient _bookingClient = BookingClient();
  final CategoryClient _categoryClient = CategoryClient();
  final AccountClient _accountClient = AccountClient();
  late final CategoryCacheService _categoryCacheService;
  late final IconCacheService _iconCacheService;
  late final SuggestionCacheService _suggestionCacheService;
  late final AccountCacheService _accountCacheService;

  BookingRepository() {
    _categoryCacheService = CategoryCacheService(_categoryClient);
    _iconCacheService = IconCacheService(_categoryClient, _accountClient);
    _suggestionCacheService = SuggestionCacheService(_bookingClient);
    _accountCacheService = AccountCacheService(_accountClient);
  }

  Future<void> checkToken() async {
    await _bookingClient.checkToken();
  }

  Future<List<BookingDataModel>> getAllBookings() async {
    return await _bookingClient.getAllBookings();
  }

  Future<List<CategoryDataModel>> getAllCategories({bool forceReload = false}) async {
    return await _categoryCacheService.getData(forceReload: forceReload);
  }

  Future<IconCacheModel> getIconCache() async {
    return await _iconCacheService.getData();
  }

  Future<void> upsertBooking(BookingDataModel model) async {
    await _bookingClient.upsertBooking(model);
  }

  Future<List<String>> getSuggestions({bool forceReload = false}) async {
    return _suggestionCacheService.getData(forceReload: forceReload);
  }

  Future<void> deleteBooking(int id) async {
    await _bookingClient.deleteBooking(id);
  }

  Future<void> createCategory(CategoryDataModel model) async {
    await _categoryClient.createCategory(model);
  }

  Future<void> editCategory(CategoryDataModel model) async {
    await _categoryClient.updateCategory(model);
  }

  Future<void> deleteCategory(int id) async {
    await _categoryClient.deleteCategory(id);
  }

  Future<List<AccountDataModel>> getAccounts({bool forceReload = false}) async {
    return await _accountCacheService.getData(forceReload: forceReload);
  }

  clearCache() {
    _categoryCacheService.clear();
    _iconCacheService.clear();
    _suggestionCacheService.clear();
    _accountCacheService.clear();
  }
}
