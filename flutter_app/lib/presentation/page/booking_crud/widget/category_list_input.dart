import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/presentation/presentation.dart';

class CategoryListInput extends StatefulWidget {
  final BookingModel model;
  final List<CategoryModel> categories;

  const CategoryListInput({required this.categories, required this.model});

  @override
  State<CategoryListInput> createState() => _CategoryListInputState();
}

class _CategoryListInputState extends State<CategoryListInput> {
  _onCategoryTap(CategoryModel category) {
    setState(() {
      widget.model.category = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: CategoryList(
          categories: widget.categories,
          categoryType: widget.model.categoryType,
          onCategoryTap: _onCategoryTap,
          selectedCategory: widget.model.category,
        ),
      ),
    );
  }
}
