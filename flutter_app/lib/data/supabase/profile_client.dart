import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';

class ProfileClient {
  Future<List<CurrencyDataModel>> getCurrencies() async {
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase.from('view_currencies').select('id, name, decimal_precision, symbol, unit_position_front');
    BudgetLogger.instance.d("view_currencies took ${stopwatch.elapsed.inMilliseconds} ms");
    return List.from(response).map((item) => CurrencyDataModel.fromJson(item)).toList();
  }

  Future<ProfileDataModel> getProfile() async {
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase.from('view_profiles').select('id, name, avatar_url').single();
    BudgetLogger.instance.d("view_profiles took ${stopwatch.elapsed.inMilliseconds} ms");
    return ProfileDataModel.fromJson(response);
  }

  Future<ProfileSettingDataModel> getProfileSetting() async {
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase.from('view_profile_settings').select('id, currency_id').single();
    BudgetLogger.instance.d("view_profile_settings took ${stopwatch.elapsed.inMilliseconds} ms");
    return ProfileSettingDataModel.fromJson(response);
  }
}
