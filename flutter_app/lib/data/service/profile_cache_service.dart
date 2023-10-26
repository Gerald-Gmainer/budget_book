import 'package:flutter_app/data/data.dart';

import 'base/base_cache_service.dart';

class ProfileCacheService extends BaseCacheService<ProfileDataModel> {
  final ProfileClient profileClient;

  ProfileCacheService(this.profileClient);

  @override
  Future<ProfileDataModel> fetchData() {
    return profileClient.getProfile();
  }

  @override
  Duration getCacheDuration() {
    return Duration(minutes: 5);
  }
}
