import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/utils/utils.dart';

class CategoryClient {
  Future<List<CategoryDataModel>> getAllCategories() async {
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase.from('view_categories').select('id, name, type').order('name', ascending: true);
    BudgetLogger.instance.d("view_categories took ${stopwatch.elapsed.inMilliseconds} ms");
    return List.from(response).map((item) => CategoryDataModel.fromJson(item)).toList();
  }

  Future<List<CategoryIconDataModel>> getCategoryIcons() async {
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase.from('view_category_icons').select('id, name');
    BudgetLogger.instance.d("view_category_icons took ${stopwatch.elapsed.inMilliseconds} ms");
    return List.from(response).map((item) => CategoryIconDataModel.fromJson(item)).toList();
  }

  Future<List<CategoryColorDataModel>> getCategoryColors() async {
    Stopwatch stopwatch = Stopwatch()..start();
    var response = await supabase.from('view_category_colors').select('id, code');
    BudgetLogger.instance.d("view_category_colors took ${stopwatch.elapsed.inMilliseconds} ms");
    return List.from(response).map((item) => CategoryColorDataModel.fromJson(item)).toList();
  }
}
