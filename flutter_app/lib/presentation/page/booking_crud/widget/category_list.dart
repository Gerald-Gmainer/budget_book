import 'package:flutter/material.dart';
import 'package:flutter_app/business_logic/business_logic.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryList extends StatelessWidget {
  final BookingCrudModel model;
  final CategoryListState state;
  final VoidCallback onCategoryTap;

  const CategoryList({required this.state, required this.onCategoryTap, required this.model});

  _reload(BuildContext context) {
    BlocProvider.of<CategoryListBloc>(context).add(LoadCategoryListEvent());
  }

  _onCategoryTap(BuildContext context, CategoryModel category) {
    model.bookingModel.categoryId = category.id;
    onCategoryTap();
  }

  @override
  Widget build(BuildContext context) {
    if (state is CategoryErrorState) {
      return ErrorText(
        message: (state as CategoryErrorState).message,
        onReload: () {
          _reload(context);
        },
      );
    }
    if (state is CategoryLoadedState) {
      return _buildView(context, (state as CategoryLoadedState).categories);
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildView(BuildContext context, List<CategoryModel> categories) {
    categories.removeWhere((category) => category.categoryType == CategoryType.income);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        final category = categories[index];
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
            Text(category.name),
          ],
        ),
      ),
    );
  }
}
