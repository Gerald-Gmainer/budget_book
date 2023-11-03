import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';

import 'base/base_client.dart';

class AccountClient extends BaseClient{
  Future<List<AccountIconDataModel>> getAccountIcons() async {
    await checkToken();
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase.from('view_account_icons').select('id, name');
    BudgetLogger.instance.d("view_account_icons took ${stopwatch.elapsed.inMilliseconds} ms");
    return List.from(response).map((item) => AccountIconDataModel.fromJson(item)).toList();
  }

  Future<List<AccountIconColorModel>> getAccountColors() async {
    await checkToken();
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase.from('view_account_colors').select('id, code');
    BudgetLogger.instance.d("view_account_colors took ${stopwatch.elapsed.inMilliseconds} ms");
    return List.from(response).map((item) => AccountIconColorModel.fromJson(item)).toList();
  }

  Future<List<AccountDataModel>> getAccounts() async {
    await checkToken();
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase.from('view_accounts').select('id, name, icon_id, color_id').order('name', ascending: true);
    BudgetLogger.instance.d("view_accounts took ${stopwatch.elapsed.inMilliseconds} ms");
    return List.from(response).map((item) => AccountDataModel.fromJson(item)).toList();
  }
}