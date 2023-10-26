import 'package:flutter_app/data/data.dart';

class UserRepository {
  final UserClient _userClient = UserClient();
  final ProfileClient _profileClient = ProfileClient();
  late final ProfileCacheService _profileCacheService;

  late final CurrencyCacheService _currencyCache;

  UserRepository() {
    _currencyCache = CurrencyCacheService(_profileClient);
    _profileCacheService = ProfileCacheService(_profileClient);
  }

  Future<bool> googleLogin() async {
    return await _userClient.googleLogin();
  }

  Future<bool> credentialsLogin(String email, String password) async {
    return await _userClient.credentialsLogin(email, password);
  }

  Future<void> signUp(String email, String password) async {
    await _userClient.signUp(email, password);
  }

  Future<void> logout() async {
    await _userClient.logout();
  }

  Future<List<CurrencyDataModel>> getCurrencies() async {
    return await _currencyCache.getData();
  }

  Future<ProfileDataModel> getProfile({bool forceReload = false}) async {
    return await _profileCacheService.getData(forceReload: forceReload);
  }
}
