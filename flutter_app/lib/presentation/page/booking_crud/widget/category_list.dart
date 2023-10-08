import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/presentation.dart';

class CategoryList extends StatelessWidget {
  final BookingModel model;
  final List<CategoryModel> categories;
  final VoidCallback onCategoryTap;

  const CategoryList({required this.onCategoryTap, required this.categories, required this.model});

  _onCategoryTap(BuildContext context, CategoryModel category) {
    model.dataModel.categoryId = category.dataModel.id;
    onCategoryTap();
  }

  _createCategory(BuildContext context) {
    Navigator.of(context).pushNamed(CategoryCrudPage.route, arguments: CategoryModel.empty(CategoryType.outcome));
  }

  @override
  Widget build(BuildContext context) {
    var trimmedList = [...categories];
    trimmedList.removeWhere((category) => category.categoryType != model.categoryType);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: trimmedList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == trimmedList.length) {
          return _buildCreateNewButton(context);
        }
        final category = trimmedList[index];
        return _buildCategory(context, category);
      },
    );
  }

  Widget _buildCategory(BuildContext context, CategoryModel category) {
    return Card(
      child: InkWell(
        onTap: () {
          _onCategoryTap(context, category);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image.network(category.imageUrl),
            Text(category.dataModel.name ?? ""),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateNewButton(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          _createCategory(context);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add),
            Text('New'),
          ],
        ),
      ),
    );
  }
}
