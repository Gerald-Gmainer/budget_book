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

    return Wrap(
      runSpacing: CategoryIcon.padding,
      spacing: CategoryIcon.padding,
      children: [
        for (int index = 0; index < trimmedList.length; index++)
          CategoryIcon(
            icon: IconConverter.getIconData(trimmedList[index].iconData?.name),
            text: trimmedList[index].name,
            color: ColorConverter.iconColorToColor(trimmedList[index].iconColor),
            isSelected: model.category == trimmedList[index],
            onTap: () {
              _onCategoryTap(context, trimmedList[index]);
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
