import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';

import 'base/base_client.dart';

class ProfileClient extends BaseClient {
  Future<List<CurrencyDataModel>> getCurrencies() async {
    await checkToken();
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase.from('view_currencies').select('id, name, decimal_precision, symbol, unit_position_front');
    BudgetLogger.instance.d("view_currencies took ${stopwatch.elapsed.inMilliseconds} ms");
    return List.from(response).map((item) => CurrencyDataModel.fromJson(item)).toList();
  }

  Future<ProfileDataModel> getProfile() async {
    await checkToken();
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase.from('view_profiles').select('id, name, email, avatar_url').single();
    BudgetLogger.instance.d("view_profiles took ${stopwatch.elapsed.inMilliseconds} ms");
    return ProfileDataModel.fromJson(response);
  }

  Future<ProfileSettingDataModel> getProfileSetting() async {
    await checkToken();
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase.from('view_profile_settings').select('id, currency_id, currency').single();
    BudgetLogger.instance.d("view_profile_settings took ${stopwatch.elapsed.inMilliseconds} ms");
    return ProfileSettingDataModel.fromJson(response);
  }
}
