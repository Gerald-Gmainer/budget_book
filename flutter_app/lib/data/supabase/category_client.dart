import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';

import 'base/base_client.dart';

class CategoryClient extends BaseClient {
  Future<List<CategoryDataModel>> getAllCategories() async {
    await checkToken();
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase.from('view_categories').select('id, name, icon_id, color_id, type').order('name', ascending: true);
    BudgetLogger.instance.d("view_categories took ${stopwatch.elapsed.inMilliseconds} ms");
    return List.from(response).map((item) => CategoryDataModel.fromJson(item)).toList();
  }

  Future<List<CategoryIconDataModel>> getCategoryIcons() async {
    await checkToken();
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase.from('view_category_icons').select('id, name');
    BudgetLogger.instance.d("view_category_icons took ${stopwatch.elapsed.inMilliseconds} ms");
    return List.from(response).map((item) => CategoryIconDataModel.fromJson(item)).toList();
  }

  Future<List<CategoryColorDataModel>> getCategoryColors() async {
    await checkToken();
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase.from('view_category_colors').select('id, code');
    BudgetLogger.instance.d("view_category_colors took ${stopwatch.elapsed.inMilliseconds} ms");
    return List.from(response).map((item) => CategoryColorDataModel.fromJson(item)).toList();
  }
}
