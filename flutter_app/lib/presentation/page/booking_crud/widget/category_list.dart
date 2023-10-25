import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_app/utils/utils.dart';

class CategoryList extends StatefulWidget {
  final BookingModel model;
  final List<CategoryModel> categories;

  const CategoryList({required this.categories, required this.model});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  _onCategoryTap(BuildContext context, CategoryModel category) {
    setState(() {
      widget.model.category = category;
    });
  }

  _createCategory(BuildContext context) {
    Navigator.of(context).pushNamed(CategoryCrudPage.route, arguments: CategoryModel.empty(categoryType: widget.model.categoryType));
  }

  @override
  Widget build(BuildContext context) {
    var trimmedList = [...widget.categories];
    trimmedList.removeWhere((category) => category.categoryType != widget.model.categoryType);

    return SingleChildScrollView(

      child: Wrap(
        runSpacing: CategoryIcon.padding,
        spacing: CategoryIcon.padding,
        children: [
          for (int index = 0; index < trimmedList.length; index++)
            CategoryIcon(
              icon: IconConverter.getIconFromModel(trimmedList[index].iconData),
              text: trimmedList[index].name,
              color: ColorConverter.iconColorToColor(trimmedList[index].iconColor),
              isSelected: widget.model.category == trimmedList[index],
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
      ),
    );
  }
}
