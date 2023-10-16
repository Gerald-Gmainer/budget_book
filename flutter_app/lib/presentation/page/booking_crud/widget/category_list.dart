import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class CategoryList extends StatelessWidget {
  final BookingModel model;
  final List<CategoryModel> categories;
  final VoidCallback onCategoryTap;

  const CategoryList({required this.onCategoryTap, required this.categories, required this.model});

  _onCategoryTap(BuildContext context, CategoryModel category) {
    model.category = category;
    onCategoryTap();
  }

  _createCategory(BuildContext context) {
    Navigator.of(context).pushNamed(CategoryCrudPage.route, arguments: CategoryModel.empty(categoryType: model.categoryType));
  }

  @override
  Widget build(BuildContext context) {
    var trimmedList = [...categories];
    trimmedList.removeWhere((category) => category.categoryType != model.categoryType);

    const double spacing = 40;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: spacing, vertical: spacing / 2),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing / 2,
          childAspectRatio: 0.7,
        ),
        itemCount: trimmedList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == trimmedList.length) {
            return CategoryIcon(
              icon: CommunityMaterialIcons.plus,
              color: AppColors.accentColor,
              text: "New",
              onTap: () {
                _createCategory(context);
              },
            );
          }
          final category = trimmedList[index];
          return CategoryIcon(
            icon: IconConverter.getIconData(category.iconData?.name),
            color: ColorConverter.iconColorToColor(category.iconColor),
            text: category.name,
            onTap: () {
              _onCategoryTap(context, category);
            },
          );
        },
      ),
    );
  }
}
