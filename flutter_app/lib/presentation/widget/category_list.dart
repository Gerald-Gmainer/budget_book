import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class CategoryList extends StatelessWidget {
  final List<CategoryModel> categories;
  final CategoryType categoryType;
  final Function(CategoryModel category) onCategoryTap;
  final CategoryModel? selectedCategory;

  const CategoryList({
    required this.categories,
    required this.categoryType,
    required this.onCategoryTap,
    this.selectedCategory,
  });

  _createCategory(BuildContext context) {
    Navigator.of(context).pushNamed(CategoryCrudPage.route, arguments: CategoryModel.empty(categoryType: categoryType));
  }

  @override
  Widget build(BuildContext context) {
    var trimmedList = [...categories];
    trimmedList.removeWhere((category) => category.categoryType != categoryType);

    return Wrap(
      runSpacing: CategoryIcon.verticalPadding,
      spacing: CategoryIcon.horizontalPadding,
      children: [
        for (int index = 0; index < trimmedList.length; index++)
          CategoryIcon(
            icon: IconConverter.getIconFromModel(trimmedList[index].iconData),
            text: trimmedList[index].name,
            color: ColorConverter.iconColorToColor(trimmedList[index].iconColor),
            isSelected: selectedCategory == trimmedList[index],
            onTap: () {
              onCategoryTap.call(trimmedList[index]);
            },
          ),
        CategoryIcon(
          icon: CommunityMaterialIcons.plus,
          color: AppColors.accentColor,
          text: "New",
          onTap: () {
            _createCategory(context);
          },
        ),
      ],
    );
  }
}
